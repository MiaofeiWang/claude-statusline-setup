# Claude Code Statusline Setup

One-command setup for a custom [Claude Code](https://docs.anthropic.com/en/docs/claude-code) status line that displays:

- **Current directory** (blue)
- **Git branch** (green)
- **Model name** (yellow)
- **Context usage** (magenta)

Example output:

```
C:/Users/me/my-project | (main) | Claude Opus 4.6 (1M context) | ctx: 12% used
```

## Quick Start

```bash
git clone https://github.com/MiaofeiWang/claude-statusline-setup.git
cd claude-statusline-setup
bash setup.sh
```

Then restart Claude Code.

## What It Does

`setup.sh` performs two steps:

1. Copies `statusline-command.sh` to `~/.claude/`
2. Adds the `statusLine` config to `~/.claude/settings.json` (preserves your existing settings)

## Requirements

- Bash (Git Bash on Windows)
- Python 3 (or Python 2 as fallback) — used for safe JSON merging
- Git — for branch detection in the status line
