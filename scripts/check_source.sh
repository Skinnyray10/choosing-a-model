#!/usr/bin/env bash
# Detects changes in the Anthropic docs pages this skill depends on, by comparing
# SHA-256 hashes with the stored ones. Only hashes are stored, never the pages.
#
#   bash scripts/check_source.sh          exit 0 = no change, 1 = something changed, other = error
#   bash scripts/check_source.sh update   store the current hashes
set -euo pipefail

SOURCES=(
  "https://platform.claude.com/docs/en/about-claude/models/choosing-a-model.md"
  "https://platform.claude.com/docs/en/models/overview.md"
  "https://platform.claude.com/docs/en/models/sonnet-5-5/whats-new-sonnet-5-5.md"
  "https://platform.claude.com/docs/en/agents-and-tools/tool-use/advisor-tool.md"
)
# For testing: SOURCE_URLS="url1 url2" replaces the list above.
if [ -n "${SOURCE_URLS:-}" ]; then read -ra SOURCES <<< "$SOURCE_URLS"; fi
HASH_FILE="${HASH_FILE:-$(cd "$(dirname "$0")/.." && pwd)/snapshot/sources.sha256}"

hash_of() {
  local page
  page="$(curl --fail --silent --show-error --location --max-time 60 "$1")"
  [ -n "$page" ] || { echo "Empty download from $1" >&2; return 2; }
  printf '%s\n' "$page" | sed 's/[[:space:]]*$//' | shasum -a 256 | cut -d' ' -f1
}

if [ "${1:-}" = "update" ]; then
  mkdir -p "$(dirname "$HASH_FILE")"
  : > "$HASH_FILE.tmp"
  for url in "${SOURCES[@]}"; do
    h="$(hash_of "$url")"
    echo "$h  $url" >> "$HASH_FILE.tmp"
  done
  mv "$HASH_FILE.tmp" "$HASH_FILE"
  echo "Stored ${#SOURCES[@]} hashes"
  exit 0
fi

[ -f "$HASH_FILE" ] || { echo "No stored hashes. Run: bash scripts/check_source.sh update" >&2; exit 2; }

changed=0
for url in "${SOURCES[@]}"; do
  now="$(hash_of "$url")"
  old="$(grep -F "  $url" "$HASH_FILE" | cut -d' ' -f1 || true)"
  if [ -z "$old" ]; then
    echo "NEW (no stored hash) $url"; changed=1
  elif [ "$old" = "$now" ]; then
    echo "ok $url"
  else
    echo "CHANGED $url"; changed=1
  fi
done
exit "$changed"
