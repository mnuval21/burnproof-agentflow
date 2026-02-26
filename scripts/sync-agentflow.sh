#!/usr/bin/env bash
# sync-agentflow.sh
#
# Run this after merging a story PR into main/dev.
# It pulls the latest code into the agentflow branch, then cherry-picks
# any spec file changes from the merged feature branch.
#
# Usage:
#   bash scripts/sync-agentflow.sh
#   bash scripts/sync-agentflow.sh feature/STORY-1-3-user-login-form
#
# The script will prompt for the feature branch if not provided.

set -e

# ── Colors ────────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

AGENTFLOW_BRANCH="agentflow"
MAIN_BRANCH="${BASE_BRANCH:-main}"

echo ""
echo -e "${BOLD}BurnProof-AgentFlow — Sync to agentflow branch${NC}"
echo ""

# ── Check we're in a git repo ─────────────────────────────────────────────────
if ! git rev-parse --git-dir &>/dev/null; then
  echo "Error: not inside a git repository."
  exit 1
fi

# ── Get feature branch ────────────────────────────────────────────────────────
FEATURE_BRANCH="${1:-}"
if [ -z "$FEATURE_BRANCH" ]; then
  read -r -p "Feature branch that was just merged (e.g. feature/STORY-1-3-user-login): " FEATURE_BRANCH
fi

if [ -z "$FEATURE_BRANCH" ]; then
  echo "Error: feature branch name is required."
  exit 1
fi

# Verify the feature branch exists (locally or remotely)
if ! git rev-parse --verify "$FEATURE_BRANCH" &>/dev/null; then
  if ! git rev-parse --verify "origin/$FEATURE_BRANCH" &>/dev/null; then
    echo -e "${YELLOW}Warning: branch '$FEATURE_BRANCH' not found locally or on origin."
    echo -e "Continuing without cherry-pick — will just sync main → agentflow.${NC}"
    FEATURE_BRANCH=""
  fi
fi

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# ── Ensure agentflow branch exists ────────────────────────────────────────────
if ! git rev-parse --verify "$AGENTFLOW_BRANCH" &>/dev/null; then
  echo -e "${CYAN}Creating agentflow branch from $MAIN_BRANCH...${NC}"
  git checkout -b "$AGENTFLOW_BRANCH" "$MAIN_BRANCH"
  echo "  ✓ agentflow branch created"
else
  git checkout "$AGENTFLOW_BRANCH"
fi

echo -e "On branch: ${CYAN}$AGENTFLOW_BRANCH${NC}"
echo ""

# ── Merge latest main into agentflow ─────────────────────────────────────────
echo "Merging $MAIN_BRANCH into agentflow..."
git merge "$MAIN_BRANCH" --no-edit -m "sync: merge $MAIN_BRANCH into agentflow"
echo -e "  ${GREEN}✓ $MAIN_BRANCH merged${NC}"

# ── Pull spec file changes from feature branch ────────────────────────────────
if [ -n "$FEATURE_BRANCH" ]; then
  echo ""
  echo "Pulling framework file changes from $FEATURE_BRANCH..."

  # Checkout only the framework directories from the feature branch
  # This brings over spec/story updates without touching app code
  FRAMEWORK_PATHS=(
    "agents"
    "templates"
    "specs"
    "intake"
    "config"
    "docs/prd.md"
    "docs/pmf.md"
    "docs/architecture.md"
    "docs/design-system.md"
    "docs/current-state.md"
    "docs/migration-guide.md"
    "docs/environments.md"
    "docs/devops.md"
    "WORKFLOW.md"
  )

  SYNCED=0
  for PATH_ENTRY in "${FRAMEWORK_PATHS[@]}"; do
    # Only pull if it exists on the feature branch
    if git show "$FEATURE_BRANCH:$PATH_ENTRY" &>/dev/null 2>&1; then
      git checkout "$FEATURE_BRANCH" -- "$PATH_ENTRY" 2>/dev/null && \
        echo "  ✓ $PATH_ENTRY" && SYNCED=$((SYNCED + 1))
    fi
  done

  if [ "$SYNCED" -gt 0 ]; then
    git add -A
    git commit -m "sync: pull framework updates from $FEATURE_BRANCH" \
      --allow-empty
    echo ""
    echo -e "  ${GREEN}✓ $SYNCED framework paths synced and committed${NC}"
  else
    echo "  No framework file changes found on $FEATURE_BRANCH"
  fi
fi

# ── Return to original branch ─────────────────────────────────────────────────
git checkout "$CURRENT_BRANCH"

echo ""
echo -e "${GREEN}${BOLD}Done.${NC}"
echo ""
echo "  agentflow branch is up to date."
echo "  Code stays clean on $MAIN_BRANCH."
echo ""
echo -e "Tip: push the agentflow branch with ${CYAN}git push origin agentflow${NC}"
echo ""
