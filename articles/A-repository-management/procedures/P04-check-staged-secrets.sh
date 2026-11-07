#!/usr/bin/env bash
# A-P04 — Check staged changes for secrets before a commit.
# Implements: A-L10
#
# Usage: P04-check-staged-secrets.sh [repo-dir]
#   Exits 0 if nothing matched, 1 if something did. Prints the file and the
#   kind of secret, never the secret itself. Changes nothing.

set -uo pipefail

repo="${1:-.}"
git -C "$repo" rev-parse --git-dir >/dev/null 2>&1 || { echo "error: not a Git repository: $repo" >&2; exit 2; }

found=0
report() { echo "SECRET   $1  ($2)"; found=1; }

check_name() {
  local f="$1" base
  base="$(basename "$f")"
  case "$base" in
    .env.example|.env.sample|.env.template) return ;;
    .env|.env.*)                    report "$f" "environment file" ;;
    *.pem|*.key|*.p12|*.pfx)        report "$f" "key or certificate file" ;;
    *.pub)                          return ;;
    id_rsa*|id_ed25519*|id_ecdsa*|id_dsa*) report "$f" "SSH private key file" ;;
    .npmrc|.pypirc|.netrc)          report "$f" "credentials file" ;;
  esac
}

check_content() {
  local f="$1" added
  added="$(git -C "$repo" diff --cached -U0 --no-color -- "$f" | grep '^+' | grep -v '^+++' || true)"
  [ -n "$added" ] || return 0
  printf '%s\n' "$added" | grep -Eq -- '-----BEGIN [A-Z ]*PRIVATE KEY-----'                 && report "$f" "private key"
  printf '%s\n' "$added" | grep -Eq 'AKIA[0-9A-Z]{16}'                                       && report "$f" "AWS access key ID"
  printf '%s\n' "$added" | grep -Eq '(ghp|gho|ghu|ghs|ghr)_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}' && report "$f" "GitHub token"
  printf '%s\n' "$added" | grep -Eq 'sk-[A-Za-z0-9_-]{20,}'                                  && report "$f" "API key (sk-...)"
  printf '%s\n' "$added" | grep -Eq 'xox[abprs]-[A-Za-z0-9-]{10,}'                           && report "$f" "Slack token"
  return 0
}

while IFS= read -r -d '' f; do
  check_name "$f"
  check_content "$f"
done < <(git -C "$repo" diff --cached --name-only --diff-filter=ACMR -z)

if [ "$found" -eq 0 ]; then
  echo "OK       no secrets found in staged changes"
else
  echo "Do not commit. Changes are left staged." >&2
fi
exit "$found"
