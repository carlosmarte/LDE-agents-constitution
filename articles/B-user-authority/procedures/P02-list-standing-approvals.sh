#!/usr/bin/env bash
# B-P02 — List standing approvals, or check whether one covers an action.
# Implements: B-L04
#
# Usage:
#   P02-list-standing-approvals.sh
#       Lists every standing approval, and every ignored entry with the reason.
#   P02-list-standing-approvals.sh --check <action> <ORG>/<repo> <branch> [default-branch]
#       Exits 0 if a standing approval covers it, 1 if not. Prints the entry used.
#       default-branch defaults to "main".
#
# LDE_USER_INSTRUCTION_FILES (colon-separated) overrides the files read (testing only).

set -uo pipefail

SHARED_ACTIONS=" push push-tag open-pr merge-pr comment delete-remote-branch send-message deploy "
files="${LDE_USER_INSTRUCTION_FILES:-$HOME/.claude/CLAUDE.md:$HOME/.codex/AGENTS.md}"

mode=list
if [ "${1:-}" = "--check" ]; then
  [ $# -ge 4 ] && [ $# -le 5 ] || { echo "usage: $0 --check <action> <ORG>/<repo> <branch> [default-branch]" >&2; exit 2; }
  mode=check; want_action="$2"; want_repo="$3"; want_branch="$4"; default_branch="${5:-main}"
elif [ $# -gt 0 ]; then
  echo "usage: $0 [--check <action> <ORG>/<repo> <branch> [default-branch]]" >&2; exit 2
fi

# Emit "file<TAB>line<TAB>entry" for each list item under "## Standing approvals".
entries() {
  local IFS=:
  for f in $files; do
    [ -f "$f" ] || continue
    awk -v f="$f" '
      /^#+[ \t]/ { inside = ($0 ~ /^##[ \t]+Standing approvals[ \t]*$/); next }
      inside && /^[ \t]*[-*][ \t]+/ { sub(/^[ \t]*[-*][ \t]+/, ""); print f "\t" NR "\t" $0 }
    ' "$f"
  done
}

found=0
count=0
while IFS=$'\t' read -r file line entry; do
  action="${entry%%:*}"; action="$(printf '%s' "$action" | tr -d '[:space:]')"
  rest="${entry#*:}"
  read -r repo_pat branch_pat _ <<< "$rest"
  where="$file:$line"

  if [ "${entry#*:}" = "$entry" ] || [ -z "${repo_pat:-}" ]; then
    [ "$mode" = list ] && echo "IGNORED   $where  \"$entry\"  (not in the form '<action>: <ORG>/<repo> [branch]')"; continue
  fi
  case "$SHARED_ACTIONS" in
    *" $action "*) ;;
    *) [ "$mode" = list ] && echo "IGNORED   $where  \"$entry\"  ('$action' is not a shared action in B-L02; destructive actions can never be standing)"; continue ;;
  esac

  count=$((count + 1))
  if [ "$mode" = list ]; then
    echo "APPROVAL  $where  $action  repo=$repo_pat  branch=${branch_pat:-<any except default>}"
    continue
  fi

  [ "$action" = "$want_action" ] || continue
  # shellcheck disable=SC2053
  [[ "$want_repo" == $repo_pat ]] || continue
  if [ -n "${branch_pat:-}" ]; then
    [[ "$want_branch" == $branch_pat ]] || continue
  else
    [ "$want_branch" != "$default_branch" ] || continue
  fi
  echo "COVERED   $want_action $want_repo $want_branch  by $where  \"$entry\""
  found=1
  break
done < <(entries)

if [ "$mode" = check ]; then
  [ "$found" -eq 1 ] && exit 0
  echo "NOT COVERED  $want_action $want_repo $want_branch  (ask the user)"
  exit 1
fi
[ "$count" -gt 0 ] || echo "No standing approvals found in: ${files//:/, }"
exit 0
