#!/usr/bin/env bash
# prepare-installer.sh
# Copies all framework files into installer/template/ so they're bundled
# when the package is published to npm.
#
# Run this before: cd installer && npm publish
#
# Usage: bash scripts/prepare-installer.sh

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE_DIR="$REPO_ROOT/installer/template"

echo "⚡ Preparing installer template..."

# Clean and recreate template directory
rm -rf "$TEMPLATE_DIR"
mkdir -p "$TEMPLATE_DIR"

# Copy framework files
cp -r "$REPO_ROOT/agents"    "$TEMPLATE_DIR/agents"
cp -r "$REPO_ROOT/templates" "$TEMPLATE_DIR/templates"
cp -r "$REPO_ROOT/intake"    "$TEMPLATE_DIR/intake"
cp -r "$REPO_ROOT/adapters"  "$TEMPLATE_DIR/adapters"
cp    "$REPO_ROOT/WORKFLOW.md" "$TEMPLATE_DIR/WORKFLOW.md"

echo "✓ Copied agents, templates, intake, adapters, WORKFLOW.md"
echo ""
echo "Template is ready at installer/template/"
echo ""
echo "To publish:"
echo "  cd installer"
echo "  npm run build"
echo "  npm publish"
echo ""
echo "Once published, users can run:"
echo "  npx create-burnproof-agentflow"
