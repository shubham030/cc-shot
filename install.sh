#!/usr/bin/env bash
# claude-code-shot installer
# Copies slash-command files into ~/.claude/commands/ so they're available
# in every Claude Code session.

set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.claude/commands"
DST_DIR="$HOME/.claude/commands"

if [[ ! -d "$SRC_DIR" ]]; then
  echo "error: $SRC_DIR not found — run this script from the claude-code-shot repo root" >&2
  exit 1
fi

mkdir -p "$DST_DIR"

echo "Installing slash commands to $DST_DIR"
for f in "$SRC_DIR"/*.md; do
  name="$(basename "$f")"
  cp "$f" "$DST_DIR/$name"
  echo "  /${name%.md}"
done

cat <<'EOF'

Done.

Open a fresh Claude Code session and try:
  /shots   — list your current displays and which /shotN captures each
  /shot    — interactive drag selection (default)
  /shotm   — main display, no mouse needed

If /shot fails with "could not create image from rect", grant your terminal
Screen Recording permission:
  System Settings → Privacy & Security → Screen Recording

Then fully quit and relaunch the terminal.
EOF
