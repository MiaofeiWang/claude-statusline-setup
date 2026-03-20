#!/usr/bin/env bash
input=$(cat)

# Extract fields using grep/sed (no jq dependency)
cwd=$(echo "$input" | grep -o '"cwd":"[^"]*"' | head -1 | sed 's/"cwd":"//;s/"$//')
model=$(echo "$input" | grep -o '"display_name":"[^"]*"' | head -1 | sed 's/"display_name":"//;s/"$//')
used=$(echo "$input" | grep -o '"used_percentage":[0-9]*' | head -1 | sed 's/"used_percentage"://')
remaining=$(echo "$input" | grep -o '"remaining_percentage":[0-9]*' | head -1 | sed 's/"remaining_percentage"://')

# Convert backslashes to forward slashes
cwd=$(echo "$cwd" | sed 's|\\\\|/|g')

# Git branch
branch=""
if [ -n "$cwd" ] && git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
           || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# Build status line with colors
parts=""
if [ -n "$cwd" ]; then
  parts="\033[1;34m${cwd}\033[0m"
fi

if [ -n "$branch" ]; then
  parts="${parts} | \033[1;32m(${branch})\033[0m"
fi

if [ -n "$model" ]; then
  parts="${parts} | \033[1;33m${model}\033[0m"
fi

if [ -n "$used" ]; then
  parts="${parts} | \033[1;35mctx: ${used}% used\033[0m"
fi

printf '%b' "$parts"
