# Adapters

Editor-specific configuration files that expose BurnProof-AgentFlow commands in your code editor.

## Available adapters

| Editor | Directory | Format |
|---|---|---|
| Claude Code | `claude-code/` | `.md` command files → copy to `.claude/commands/` |
| Cursor | `cursor/` | `.mdc` rule files → copy to `.cursor/rules/` |
| Copilot | `copilot/` | Coming soon |
| Windsurf | `windsurf/` | Coming soon |

## Setup

### Claude Code
```bash
mkdir -p .claude/commands
cp adapters/claude-code/*.md .claude/commands/
```
Then use `/rex` or `/new-story` in any Claude Code session.

### Cursor
```bash
mkdir -p .cursor/rules
cp adapters/cursor/*.mdc .cursor/rules/
```
Then use `@rex` or `@new-story` in Cursor chat.

## Available commands

| Command | What it does |
|---|---|
| `rex` / `@rex` | Start Rex, the project orchestrator |
| `new-story` / `@new-story` | Scaffold a new story from the template |
