#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0" 2>/dev/null || realpath "$0")")" && pwd)"
REMAPPING="$SCRIPT_DIR/key_remapping.json"

if [ ! -f "$REMAPPING" ]; then
  echo "error: key_remapping.json not found at $REMAPPING" >&2
  exit 1
fi

hidutil property --set "$(cat "$REMAPPING")"
