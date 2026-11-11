#!/usr/bin/env bash
# Detects changes in Anthropic's model-selection guide by comparing a SHA-256
# of the page with the stored one. Only the hash is stored, not the page.
#
#   bash scripts/check_source.sh          exit 0 = same, 1 = changed, other = error
#   bash scripts/check_source.sh update   store the current hash
set -euo pipefail

URL="${GUIDE_URL:-https://platform.claude.com/docs/en/about-claude/models/choosing-a-model.md}"
HASH_FILE="${HASH_FILE:-$(cd "$(dirname "$0")/.." && pwd)/snapshot/guide.sha256}"

page="$(curl --fail --silent --show-error --location --max-time 60 "$URL")"
[ -n "$page" ] || { echo "Empty download from $URL" >&2; exit 2; }
now="$(printf '%s\n' "$page" | sed 's/[[:space:]]*$//' | shasum -a 256 | cut -d' ' -f1)"

if [ "${1:-}" = "update" ]; then
  mkdir -p "$(dirname "$HASH_FILE")"
  echo "$now" > "$HASH_FILE"
  echo "Stored hash $now"
  exit 0
fi

[ -f "$HASH_FILE" ] || { echo "No stored hash. Run: bash scripts/check_source.sh update" >&2; exit 2; }

if [ "$now" = "$(cat "$HASH_FILE")" ]; then
  echo "No changes"
else
  echo "The guide changed (hash differs from snapshot/guide.sha256)"
  exit 1
fi
