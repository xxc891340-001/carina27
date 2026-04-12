#!/usr/bin/env bash
# Run this once after cloning to install project dev tooling.
set -e

echo "Installing gstack (AI dev skills for Claude Code)..."
if [ -d "$HOME/.claude/skills/gstack" ]; then
  echo "  gstack already installed — upgrading..."
  cd "$HOME/.claude/skills/gstack" && git pull --ff-only && ./setup
else
  git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git "$HOME/.claude/skills/gstack"
  cd "$HOME/.claude/skills/gstack" && ./setup
fi

echo ""
echo "✓ Setup complete. gstack skills are available in Claude Code."
