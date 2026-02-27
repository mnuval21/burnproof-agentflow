#!/usr/bin/env bash
# BurnProof-AgentFlow — curl installer
# Usage: curl -fsSL https://raw.githubusercontent.com/YOUR-ORG/burnproof-agentflow/main/scripts/install.sh | bash
#
# Installs directly from GitHub — no Node.js required.

set -e

REPO="mnuval21/burnproof-agentflow"
BRANCH="main"
TARBALL_URL="https://github.com/$REPO/archive/refs/heads/$BRANCH.tar.gz"

# ── Colors ────────────────────────────────────────────────────────────────────
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

# ── Banner ────────────────────────────────────────────────────────────────────
echo ""
echo -e "${PURPLE}${BOLD}  BurnProof-AgentFlow Installer ⚡  ${NC}"
echo ""

TARGET="$(pwd)"
echo -e "Installing into: ${CYAN}$TARGET${NC}"
echo ""

# ── Guard: already installed? ─────────────────────────────────────────────────
if [ -d "$TARGET/.agentflow" ]; then
  echo -e "${YELLOW}Warning: .agentflow/ already exists here.${NC}"
  if [ -t 0 ]; then
    read -r -p "Overwrite existing installation? [y/N] " CONFIRM
  else
    read -r -p "Overwrite existing installation? [y/N] " CONFIRM < /dev/tty
  fi
  if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
  fi
  echo ""
fi

# ── Editor choice ─────────────────────────────────────────────────────────────
echo "Which editor are you using?"
echo "  1) Claude Code   — adds /rex and /new-story commands"
echo "  2) Cursor        — adds @rex and @new-story rules"
echo "  3) Both"
echo "  4) Skip          — I'll set up adapters manually"
echo ""

# Force read from terminal even if stdin is piped
if [ -t 0 ]; then
  read -r -p "Choice [1-4]: " EDITOR_CHOICE
else
  read -r -p "Choice [1-4]: " EDITOR_CHOICE < /dev/tty
fi
echo ""

case "$EDITOR_CHOICE" in
  1) EDITOR="claude-code" ;;
  2) EDITOR="cursor" ;;
  3) EDITOR="both" ;;
  4) EDITOR="none" ;;
  *) echo "Invalid choice. Defaulting to skip."; EDITOR="none" ;;
esac

# ── Download ──────────────────────────────────────────────────────────────────
echo "Downloading BurnProof-AgentFlow..."
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

if command -v curl &>/dev/null; then
  curl -fsSL "$TARBALL_URL" | tar -xz -C "$TMP"
elif command -v wget &>/dev/null; then
  wget -qO- "$TARBALL_URL" | tar -xz -C "$TMP"
else
  echo "Error: curl or wget is required."
  exit 1
fi

# The extracted directory name includes the branch name
SRC="$TMP/$(ls "$TMP")"

# ── Copy core files ───────────────────────────────────────────────────────────
echo "Installing..."
mkdir -p "$TARGET/.agentflow"

cp -r "$SRC/agents"     "$TARGET/.agentflow/agents"
echo "  ✓ .agentflow/agents/"

cp -r "$SRC/templates"  "$TARGET/.agentflow/templates"
echo "  ✓ .agentflow/templates/"

cp -r "$SRC/intake"     "$TARGET/.agentflow/intake"
echo "  ✓ .agentflow/intake/"

cp    "$SRC/WORKFLOW.md" "$TARGET/.agentflow/WORKFLOW.md"
echo "  ✓ .agentflow/WORKFLOW.md"

# ── Set up .gitattributes (Option A — auto-strip .agentflow/ on merge to main) ─
GITATTRIBUTES="$TARGET/.gitattributes"
ATTR_ENTRY='.agentflow/ merge=ours'

if [ -f "$GITATTRIBUTES" ]; then
  if ! grep -q '\.agentflow/' "$GITATTRIBUTES"; then
    printf '\n# BurnProof-AgentFlow — strip on merge to main\n%s\n' "$ATTR_ENTRY" >> "$GITATTRIBUTES"
    echo "  ✓ .gitattributes updated"
  else
    echo "  ✓ .gitattributes already configured"
  fi
else
  printf '# BurnProof-AgentFlow — strip on merge to main\n%s\n' "$ATTR_ENTRY" > "$GITATTRIBUTES"
  echo "  ✓ .gitattributes created"
fi

# Configure git merge driver (required for merge=ours to work)
if git rev-parse --git-dir > /dev/null 2>&1; then
  git config merge.ours.driver true
  echo "  ✓ git merge driver configured"
fi

# ── Create empty project directories ─────────────────────────────────────────
mkdir -p \
  "$TARGET/.agentflow/specs/epics" \
  "$TARGET/.agentflow/specs/stories" \
  "$TARGET/.agentflow/specs/contracts" \
  "$TARGET/.agentflow/docs/intake" \
  "$TARGET/.agentflow/config"
echo "  ✓ .agentflow/specs/, docs/, config/"

# ── Editor adapters ───────────────────────────────────────────────────────────
if [[ "$EDITOR" == "claude-code" || "$EDITOR" == "both" ]]; then
  mkdir -p "$TARGET/.claude/commands"
  cp -r "$SRC/adapters/claude-code/." "$TARGET/.claude/commands/"
  echo "  ✓ Claude Code adapter → .claude/commands/"
fi

if [[ "$EDITOR" == "cursor" || "$EDITOR" == "both" ]]; then
  mkdir -p "$TARGET/.cursor/rules"
  cp -r "$SRC/adapters/cursor/." "$TARGET/.cursor/rules/"
  echo "  ✓ Cursor adapter → .cursor/rules/"
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}⚡ BurnProof-AgentFlow is installed.${NC}"
echo ""
echo -e "${BOLD}Next steps:${NC}"

STEP=1
if [[ "$EDITOR" == "claude-code" || "$EDITOR" == "both" ]]; then
  echo "  $STEP. Run /rex in Claude Code to start"
  STEP=$((STEP + 1))
fi
if [[ "$EDITOR" == "cursor" || "$EDITOR" == "both" ]]; then
  echo "  $STEP. Use @rex in Cursor to start"
  STEP=$((STEP + 1))
fi
if [[ "$EDITOR" == "none" ]]; then
  echo "  $STEP. Open .agentflow/agents/orchestrator-agent.md and load it as your agent"
  STEP=$((STEP + 1))
fi
echo "  $STEP. Drop any reference files in .agentflow/intake/ before your first session"
STEP=$((STEP + 1))
echo "  $STEP. See .agentflow/WORKFLOW.md for the full guide"
echo ""
