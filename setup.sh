#!/usr/bin/env bash
set -e

CLAUDE_DIR="$HOME/.claude"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Claude Code Statusline Setup ==="
echo ""

# 1. Ensure ~/.claude/ exists
mkdir -p "$CLAUDE_DIR"

# 2. Copy statusline-command.sh
cp "$SCRIPT_DIR/statusline-command.sh" "$CLAUDE_DIR/statusline-command.sh"
echo "[OK] Copied statusline-command.sh -> $CLAUDE_DIR/statusline-command.sh"

# 3. Merge statusLine config into settings.json using Python
python3 -c "
import json, os, sys

path = os.path.join(os.path.expanduser('~'), '.claude', 'settings.json')

# Load existing settings or start fresh
settings = {}
if os.path.isfile(path):
    with open(path, 'r') as f:
        settings = json.load(f)

# Add statusLine block
settings['statusLine'] = {
    'type': 'command',
    'command': 'bash ~/.claude/statusline-command.sh'
}

with open(path, 'w') as f:
    json.dump(settings, f, indent=2)
    f.write('\n')
" 2>/dev/null || python -c "
import json, os, sys

path = os.path.join(os.path.expanduser('~'), '.claude', 'settings.json')

settings = {}
if os.path.isfile(path):
    with open(path, 'r') as f:
        settings = json.load(f)

settings['statusLine'] = {
    'type': 'command',
    'command': 'bash ~/.claude/statusline-command.sh'
}

with open(path, 'w') as f:
    json.dump(settings, f, indent=2)
    f.write('\n')
"

echo "[OK] Updated settings.json with statusLine config"
echo ""
echo "Done! Restart Claude Code to see the status line."
