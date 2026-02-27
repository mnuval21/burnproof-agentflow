# BurnProof-AgentFlow ⚡

A spec-driven multi-agent framework for shipping software with AI — without the chaos.

Built for teams who want specialized agents doing focused work, a living paper trail that stays aligned as things change, and a single human-facing interface so you never have to wrangle agents yourself.

---

## How it works

You talk to one agent: **Rex**. Rex assembles the right team, manages the entire workflow, and reports back to you. The agents handle everything else behind the scenes.

```
You → Rex → [assembles team] → manages workflow → ships code → reports back to You
```

Every spec lives as a file. Every decision is documented. Every drift is logged and approved before it's implemented. Code stays clean on `main`. Context lives in `.agentflow/` on `dev`, stripped automatically on merge via `.gitattributes`.

---

## Install

**curl (no Node required):**
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR-ORG/burnproof-agentflow/main/scripts/install.sh | bash
```

**npx:**
```bash
npx create-burnproof-agentflow
```

**local (from this repo):**
```bash
node installer/dist/index.js
```

**Uninstall:**
```bash
curl -fsSL https://raw.githubusercontent.com/mnuval21/burnproof-agentflow/main/scripts/uninstall.sh | bash
```

---

## Start a project

**Claude Code:**
```
/rex
```

**Cursor:**
```
@rex
```

That's it. Rex wakes up, checks for existing state, scans your `.agentflow/intake/` folder, and asks: *"What are we building?"*

---

## Drop reference files first

Before running `/rex`, drop anything useful into `.agentflow/intake/`:

- Screenshots of competitor apps or inspiration
- Brand guidelines, logo files
- Existing specs, meeting notes, feature docs
- API docs from third-party integrations

Rex scans the folder at kickoff and routes each file to the right agent automatically.

---

## What's included

```
.agentflow/         All agent context — installed into your project
  agents/           13 specialized agents — each with a focused role
  templates/        Story, Epic, PRD, contract, PR, and project state templates
  intake/           Drop reference files here before starting
  docs/             Generated specs, PRDs, architecture, wireframes
  specs/            Living epics, stories, and API contracts
  config/           Project state, board, parallelization config

adapters/           Editor commands for Claude Code and Cursor (→ .claude/ or .cursor/)
scripts/            Install and publish scripts
installer/          npx-publishable CLI installer
WORKFLOW.md         Complete guide to the framework
```

---

## The agent team

| Agent | Role | Model |
|---|---|---|
| **Rex (Orchestrator)** | Single human interface — runs the whole team | Opus |
| PRD Agent | Discovery interview → product requirements doc | Opus |
| Architect Agent | Tech stack, system design, API contracts | Opus |
| UI/UX Designer Agent | Design system, wireframes, accessibility | Opus |
| PM Agent | Epics, stories, PMF analysis, backlog | Opus |
| PO Agent | Pre-dev validation, post-story alignment sweeps | Sonnet |
| Codebase Audit Agent | Maps existing codebases (brownfield only) | Sonnet |
| Frontend Dev Agent | TDD UI implementation against contracts | Sonnet |
| Backend Dev Agent | TDD API/DB implementation | Sonnet |
| Fullstack Dev Agent | Sequential full-stack implementation | Sonnet |
| QA Agent | Contract compliance, accessibility, security verification | Sonnet |
| DevOps Agent | CI/CD pipeline, environments, deployment | Sonnet |
| Documentation Agent | README, API docs, user guide, onboarding | Sonnet |

---

## Git strategy

```
dev               →  everything: app code + .agentflow/ context (tracked)
main              →  code only (.agentflow/ stripped automatically on merge)
feature/STORY-X   →  dev agents write here → PR to dev
```

`.gitattributes` handles the strip automatically — no branch switching needed. The installer sets this up. New team members just run the installer and start building.

---

## Key features

- **Spec-driven** — every feature starts as a story with testable acceptance criteria
- **Living specs** — story files track AC completion, drift proposals, and alignment sweeps
- **Drift control** — agents log proposals, PO Agent assesses impact, human approves before anything changes
- **TDD** — tests written before every implementation, no exceptions
- **Parallel development** — frontend and backend agents work simultaneously against API contracts
- **PMF-first backlog** — aha moment and engagement loop defined before any epics
- **Accessibility built in** — WCAG 2.1 AA checked at design, implementation, and QA
- **Context-efficient** — Rex reads a lean project state file, not the whole codebase
- **Brownfield ready** — codebase audit agent maps existing code before any new specs are written

---

## Full guide

See [WORKFLOW.md](./.agentflow/WORKFLOW.md) for the complete walkthrough — phases, parallelization modes, agent quick reference, and FAQ.

---

## Publishing the installer

```bash
# Bundle framework files into the installer package
bash scripts/prepare-installer.sh

# Publish to npm
cd installer && npm run build && npm publish
```
