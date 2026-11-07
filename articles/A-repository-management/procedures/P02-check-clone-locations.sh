#!/usr/bin/env bash
# A-P02 — Check that every clone under the clone root is at its canonical location.
# Implements: A-L01
#
# Usage: P02-check-clone-locations.sh [clone-root]
#   Exits 0 when every clone is in place, 1 when any is not. Read-only.

set -uo pipefail

root="${1:-/Users/Shared/agent/repos/clone}"
root="${root%/}"
[ -d "$root" ] || { echo "no clone root at $root"; exit 0; }

status=0
for dir in "$root"/*/*/; do
  [ -d "$dir" ] || continue
  dir="${dir%/}"
  rel="${dir#"$root"/}"

  if [ ! -d "$dir/.git" ]; then
    echo "NOT A REPO  $rel"; status=1; continue
  fi

  origin="$(git -C "$dir" remote get-url origin 2>/dev/null || true)"
  if [ -z "$origin" ]; then
    echo "NO ORIGIN   $rel"; status=1; continue
  fi

  expected="$origin"
  for prefix in "https://github.com/" "http://github.com/" "ssh://git@github.com/" "git@github.com:"; do
    expected="${expected#"$prefix"}"
  done
  if [ "$expected" = "$origin" ]; then
    echo "NOT GITHUB  $rel  (origin: $origin)"; continue
  fi
  expected="${expected%/}"
  expected="${expected%.git}"

  if [ "$expected" = "$rel" ]; then
    echo "OK          $rel"
  else
    echo "MISPLACED   $rel  (origin is $expected)"; status=1
  fi
done

exit $status
