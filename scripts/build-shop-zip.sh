#!/usr/bin/env bash
# Build the Med Tracker shop zip from an allow-list.
# No git data, no environment files, no secrets.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
STAGE="$(mktemp -d)"
OUT="$ROOT/dist"
ZIP="$OUT/med-tracker-shop.zip"

cleanup() {
  rm -rf "$STAGE"
}
trap cleanup EXIT

FILES=(
  index.html
  manifest.json
  sw.js
  icon-180.png
  icon-192.png
  icon-512.png
  icon-maskable-192.png
  icon-maskable-512.png
  README.md
  GUIDE.md
  LICENCE.md
  DISCLAIMER.md
)

mkdir -p "$STAGE/med-tracker"
for file in "${FILES[@]}"; do
  if [[ ! -f "$ROOT/$file" ]]; then
    echo "Missing shop file: $file" >&2
    exit 1
  fi
  cp "$ROOT/$file" "$STAGE/med-tracker/$file"
done

if grep -RInE \
  -e 'AKIA[0-9A-Z]{16}' \
  -e 'BEGIN [A-Z ]*PRIVATE KEY' \
  -e 'x-access-token' \
  -e 'api[_-]?key[[:space:]]*[:=]' \
  -e 'secret[[:space:]]*[:=]' \
  -e 'ghp_[A-Za-z0-9]{20,}' \
  "$STAGE/med-tracker" >/dev/null; then
  echo "Refusing to pack: secret-like text found." >&2
  exit 1
fi

mkdir -p "$OUT"
rm -f "$ZIP"
(
  cd "$STAGE"
  zip -r -X "$ZIP" med-tracker
)

echo "Wrote $ZIP"
unzip -l "$ZIP"
