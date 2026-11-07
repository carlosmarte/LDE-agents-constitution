#!/usr/bin/env bash
# A-P03 — Check a branch name against the shared format.
# Implements: A-L08
#
# Usage: P03-check-branch-name.sh [branch-name]
#   With no argument, checks the current branch of the repository in the
#   current directory. Exits 0 if the name is valid, 1 if not.
#   Only use it for repositories with no branch naming convention of their own.

set -euo pipefail

name="${1:-$(git branch --show-current)}"
[ -n "$name" ] || { echo "error: no branch name given and HEAD is detached" >&2; exit 2; }

types="feat|fix|docs|chore|refactor|test"
description="${name#*/}"

if ! printf '%s' "$name" | grep -Eq "^($types)/[a-z0-9]+(-[a-z0-9]+)*$"; then
  echo "INVALID  $name  (expected <type>/<kebab-description>, type one of: ${types//|/, })"
  exit 1
fi
if [ "${#description}" -gt 50 ]; then
  echo "INVALID  $name  (description is ${#description} characters; at most 50)"
  exit 1
fi
echo "OK       $name"
