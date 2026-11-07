#!/usr/bin/env bash
# A-P06 — Report which branches and worktrees cleanup may remove.
# Implements: A-L15
#
# Usage: P06-cleanup-report.sh [repo-dir]
#   Runs `git fetch origin --prune`, then prints one line per local branch and
#   per extra worktree: REMOVE (safe under A-L15) or KEEP (with the reason).
#   Removes nothing. LDE_WORKTREE_ROOT overrides the worktree root (testing only).

set -uo pipefail

WORKTREE_ROOT="${LDE_WORKTREE_ROOT:-/Users/Shared/agent/repos/worktree}"
repo="$(git -C "${1:-.}" rev-parse --show-toplevel 2>/dev/null)" || { echo "error: not a Git repository: ${1:-.}" >&2; exit 2; }
g() { git -C "$repo" "$@"; }

g fetch origin --prune --quiet 2>/dev/null || echo "warning: could not fetch origin; using last known state" >&2

default="$(g symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's#^origin/##')"
if [ -z "$default" ]; then
  for b in main master; do g show-ref --verify --quiet "refs/remotes/origin/$b" && { default="$b"; break; }; done
fi
[ -n "$default" ] || { echo "error: cannot find the default branch on origin" >&2; exit 2; }
target="origin/$default"
echo "default branch: $default (comparing against $target)"

# Map checked-out branches to their worktree paths.
checked_out=""
wt_paths=()
wt_branches=()
while IFS= read -r line; do
  case "$line" in
    "worktree "*) wt_path="${line#worktree }" ;;
    "branch refs/heads/"*) b="${line#branch refs/heads/}"
                           checked_out="$checked_out|$b|"
                           wt_paths+=("$wt_path"); wt_branches+=("$b") ;;
    "detached") wt_paths+=("$wt_path"); wt_branches+=("") ;;
  esac
done < <(g worktree list --porcelain)

echo "== branches"
while IFS= read -r b; do
  if [ "$b" = "$default" ]; then
    echo "KEEP    branch $b  (default branch)"
  elif [ "${checked_out#*|$b|}" != "$checked_out" ]; then
    echo "KEEP    branch $b  (checked out in a worktree)"
  elif g merge-base --is-ancestor "refs/heads/$b" "$target" 2>/dev/null; then
    echo "REMOVE  branch $b  (merged into $target)"
  else
    reason="not merged into $target"
    up="$(g rev-parse --abbrev-ref "$b@{upstream}" 2>/dev/null || true)"
    if [ -n "$up" ]; then
      ahead="$(g rev-list --count "$up..refs/heads/$b" 2>/dev/null || echo 0)"
      [ "$ahead" -gt 0 ] && reason="$reason; $ahead unpushed commit(s)"
    else
      reason="$reason; never pushed"
    fi
    echo "KEEP    branch $b  ($reason)"
  fi
done < <(g for-each-ref refs/heads --format='%(refname:short)')

echo "== worktrees"
main_wt="${wt_paths[0]:-}"
for i in "${!wt_paths[@]}"; do
  p="${wt_paths[$i]}"; b="${wt_branches[$i]}"
  [ "$p" = "$main_wt" ] && continue
  case "$p" in
    "$WORKTREE_ROOT"/*) ;;
    *) echo "KEEP    worktree $p  (outside the worktree root; not agent-created)"; continue ;;
  esac
  if [ -n "$(git -C "$p" status --porcelain 2>/dev/null)" ]; then
    echo "KEEP    worktree $p  (uncommitted changes)"
  elif [ -z "$b" ]; then
    echo "KEEP    worktree $p  (detached HEAD)"
  elif g merge-base --is-ancestor "refs/heads/$b" "$target" 2>/dev/null; then
    echo "REMOVE  worktree $p  (branch $b merged into $target; clean)"
  else
    echo "KEEP    worktree $p  (branch $b not merged into $target)"
  fi
done
exit 0
