#!/usr/bin/env bash
# I-P01 — Clone a GitHub repository, or update the existing clone.
# Implements: I-L01, I-L02, I-L03, I-L04, I-L05
#
# Usage: P01-clone-or-update.sh <github-url> [explicit-destination]
#   Prints the clone's path on the last line of stdout.
#   Pass explicit-destination only when the user named that path (I-L05).

set -euo pipefail

CLONE_ROOT="/Users/Shared/agent/repos/clone"   # I-L01

die() { echo "error: $*" >&2; exit 1; }
[ $# -ge 1 ] && [ $# -le 2 ] || { echo "usage: $0 <github-url> [explicit-destination]" >&2; exit 2; }

url="$1"

# Reduce any GitHub URL form to "<ORG>/<repo>[/extra]" (I-L01).
rest="$url"
for prefix in "https://github.com/" "http://github.com/" "ssh://git@github.com/" "git@github.com:"; do
  rest="${rest#"$prefix"}"
done
[ "$rest" != "$url" ] || die "not a github.com URL: $url"

org="${rest%%/*}"
repo="${rest#*/}"
repo="${repo%%/*}"      # drop /tree/main and similar
repo="${repo%.git}"
[ -n "$org" ] && [ -n "$repo" ] && [ "$org" != "$rest" ] || die "cannot read <ORG>/<repo> from: $url"

case "$url" in
  git@*|ssh://*) clone_url="git@github.com:$org/$repo.git" ;;
  *)             clone_url="https://github.com/$org/$repo" ;;
esac

dest="${2:-$CLONE_ROOT/$org/$repo}"

if [ -d "$dest/.git" ]; then
  # I-L03: reuse, never re-clone.
  echo "reusing existing clone: $dest" >&2
  git -C "$dest" fetch --all --prune >&2
  # I-L04: report uncommitted changes, never touch them.
  if [ -n "$(git -C "$dest" status --porcelain)" ]; then
    echo "warning: $dest has uncommitted changes; left untouched. Ask the user before pulling." >&2
  fi
elif [ -e "$dest" ] && [ -n "$(ls -A "$dest" 2>/dev/null)" ]; then
  die "$dest exists and is not a Git repository; refusing to overwrite it (I-L03)"
else
  mkdir -p "$(dirname "$dest")" || die "cannot create $(dirname "$dest") (I-L02)"
  git clone "$clone_url" "$dest" >&2
fi

echo "$dest"
