#!/usr/bin/env bash
# BurnProof-AgentFlow — uninstaller
# Usage: curl -fsSL https://raw.githubusercontent.com/mnuval21/burnproof-agentflow/main/scripts/uninstall.sh | bash
# Or run directly: bash scripts/uninstall.sh

set -e

# ── Colors ────────────────────────────────────────────────────────────────────
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo -e "${PURPLE}${BOLD}  BurnProof-AgentFlow Uninstaller  ${NC}"
echo ""

TARGET="$(pwd)"

# ── Confirm ───────────────────────────────────────────────────────────────────
if [ ! -d "$TARGET/.agentflow" ]; then
  echo "No .agentflow/ found in $(pwd) — nothing to uninstall."
  exit 0
fi

echo -e "${YELLOW}This will remove:${NC}"
echo "  .agentflow/"
echo "  .gitattributes (if created by BurnProof-AgentFlow)"
echo "  .claude/commands/rex.md + new-story.md (if present)"
echo "  .cursor/rules/rex.mdc + new-story.mdc (if present)"
echo "  git config merge.ours.driver"
echo ""

if [ -t 0 ]; then
  read -r -p "Remove BurnProof-AgentFlow from this project? [y/N] " CONFIRM
else
  read -r -p "Remove BurnProof-AgentFlow from this project? [y/N] " CONFIRM < /dev/tty
fi

if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
  echo "Cancelled."
  exit 0
fi
echo ""

# ── Remove .agentflow/ ────────────────────────────────────────────────────────
rm -rf "$TARGET/.agentflow"
echo "  ✓ .agentflow/ removed"

# ── Remove .gitattributes if it only has our entry ────────────────────────────
GITATTRIBUTES="$TARGET/.gitattributes"
if [ -f "$GITATTRIBUTES" ]; then
  if grep -q '\.agentflow/' "$GITATTRIBUTES"; then
    # Remove our block (the comment line + the entry)
    sed -i.bak '/# BurnProof-AgentFlow — strip on merge to main/d' "$GITATTRIBUTES"
    sed -i.bak '/\.agentflow\/ merge=ours/d' "$GITATTRIBUTES"
    rm -f "$GITATTRIBUTES.bak"
    # If file is now empty (or only whitespace), remove it
    if [ -z "$(tr -d '[:space:]' < "$GITATTRIBUTES")" ]; then
      rm "$GITATTRIBUTES"
      echo "  ✓ .gitattributes removed"
    else
      echo "  ✓ .gitattributes cleaned (other entries preserved)"
    fi
  fi
fi

# ── Remove git merge driver config ────────────────────────────────────────────
if git rev-parse --git-dir > /dev/null 2>&1; then
  if git config merge.ours.driver > /dev/null 2>&1; then
    git config --unset merge.ours.driver
    echo "  ✓ git merge driver config removed"
  fi
fi

# ── Remove Claude Code adapter ────────────────────────────────────────────────
REMOVED_ADAPTER=false
for f in rex.md new-story.md; do
  if [ -f "$TARGET/.claude/commands/$f" ]; then
    rm "$TARGET/.claude/commands/$f"
    REMOVED_ADAPTER=true
  fi
done
$REMOVED_ADAPTER && echo "  ✓ Claude Code commands removed"

# ── Remove Cursor adapter ─────────────────────────────────────────────────────
REMOVED_CURSOR=false
for f in rex.mdc new-story.mdc; do
  if [ -f "$TARGET/.cursor/rules/$f" ]; then
    rm "$TARGET/.cursor/rules/$f"
    REMOVED_CURSOR=true
  fi
done
$REMOVED_CURSOR && echo "  ✓ Cursor rules removed"

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}BurnProof-AgentFlow removed.${NC}"
echo ""
echo "To reinstall:"
echo "  curl -fsSL https://raw.githubusercontent.com/mnuval21/burnproof-agentflow/main/scripts/install.sh | bash"
echo ""
