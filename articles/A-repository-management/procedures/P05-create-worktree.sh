#!/usr/bin/env bash
# A-P05 — Create (or reuse) an agent worktree at its required location.
# Implements: A-L14
#
# Usage: P05-create-worktree.sh <repo-dir> <branch> [base]
#   Creates /Users/Shared/agent/repos/worktree/<ORG>/<repo>/<branch with / -> ->.
#   If <branch> does not exist, it is created from [base], which defaults to
#   origin/<default branch>. Prints the worktree path on the last line.
#   LDE_WORKTREE_ROOT overrides the worktree root (for testing only).

set -euo pipefail

WORKTREE_ROOT="${LDE_WORKTREE_ROOT:-/Users/Shared/agent/repos/worktree}"

die() { echo "error: $*" >&2; exit 1; }
[ $# -ge 2 ] && [ $# -le 3 ] || { echo "usage: $0 <repo-dir> <branch> [base]" >&2; exit 2; }

repo="$(git -C "$1" rev-parse --show-toplevel 2>/dev/null)" || die "not a Git repository: $1"
branch="$2"

# <ORG>/<repo> from origin, as A-L01 derives them; "local/<dir>" without origin.
origin="$(git -C "$repo" remote get-url origin 2>/dev/null || true)"
if [ -n "$origin" ]; then
  path="${origin%/}"; path="${path%.git}"; path="${path//://}"
  name="${path##*/}"; path="${path%/*}"; org="${path##*/}"
else
  org="local"; name="$(basename "$repo")"
fi

dest="$WORKTREE_ROOT/$org/$name/${branch//\//-}"

if [ -e "$dest/.git" ]; then
  [ "$(git -C "$dest" rev-parse --path-format=absolute --git-common-dir)" = "$(git -C "$repo" rev-parse --path-format=absolute --git-common-dir)" ] \
    || die "$dest exists and belongs to a different repository"
  echo "reusing existing worktree: $dest" >&2
elif [ -e "$dest" ]; then
  die "$dest exists and is not a worktree; refusing to overwrite it"
else
  mkdir -p "$(dirname "$dest")" || die "cannot create $(dirname "$dest")"
  if git -C "$repo" show-ref --verify --quiet "refs/heads/$branch"; then
    git -C "$repo" worktree add "$dest" "$branch" >&2
  else
    base="${3:-}"
    if [ -z "$base" ]; then
      base="$(git -C "$repo" symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null || true)"
      [ -n "$base" ] || base="HEAD"
    fi
    git -C "$repo" worktree add -b "$branch" "$dest" "$base" >&2
  fi
fi

echo "$dest"
