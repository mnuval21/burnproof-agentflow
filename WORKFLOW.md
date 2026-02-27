# BurnProof-AgentFlow — Complete Workflow Guide

> **Who this is for:** Builders of all experience levels who want to ship software with AI agents without the chaos of missed requirements, broken integrations, or endless rework.
>
> **What this framework does:** It puts the right AI agent on the right task at the right time — with a living paper trail that keeps everyone aligned, even as things change.

---

## The Big Picture

Most AI-assisted development breaks down in one of three ways:
1. **The agent doesn't know what to build** — vague instructions → vague code
2. **The agents don't know what each other built** — parallel work that doesn't fit together
3. **The spec drifts silently** — the plan changes but nobody updates the documents

BurnProof-AgentFlow solves all three by combining specialized agents, living spec documents, and a human approval gate on every meaningful change.

---

## How to Start

**You only ever talk to one agent: the Orchestrator.**

The Orchestrator interviews you, assembles the right team for your project, and manages every agent on your behalf. You never need to know which agents exist or when to summon them — the Orchestrator handles all of that.

```
You → Orchestrator → [assembles team] → manages entire workflow → reports back to You
```

To start a project, simply invoke the Orchestrator Agent and say:
> "I want to start a new project" or "I want to add a feature to my existing app"

The Orchestrator takes it from there.

**Got reference files?** Drop screenshots, brand assets, existing docs, or API guides into the `.agentflow/intake/` folder before starting. Rex will scan it automatically at kickoff and route everything to the right agents.

---

## Full Workflow at a Glance

```
┌─────────────────────────────────────────────────────────┐
│  YOU → ORCHESTRATOR (Opus)                              │
│  "What are we building?"                                │
│  Assembles the right team for your project              │
│  Human confirms team → workflow begins                  │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│  PHASE 0 — START                                        │
│  New project? → Greenfield path                         │
│  Existing code? → Brownfield path (audit first)         │
└────────────────────┬────────────────────────────────────┘
                     │
         ┌───────────▼───────────┐
         │  [BROWNFIELD ONLY]    │
         │  Codebase Audit Agent │  Sonnet
         │  → .agentflow/docs/   │
         │    current-state.md   │
         └───────────┬───────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│  PHASE 1 — DISCOVERY                                    │
│  PRD Agent interviews human                  Opus       │
│  (brownfield: reads audit first)                        │
│  → .agentflow/docs/prd.md   ◄── Human approves          │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│  PHASE 2 — ARCHITECTURE                                 │
│  Architect Agent                             Opus       │
│  → .agentflow/docs/architecture.md                      │
│  → .agentflow/specs/contracts/*.md ◄── Human approves   │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│  PHASE 3 — PLANNING                                     │
│  PM Agent creates Epics + Stories            Opus       │
│  → .agentflow/specs/epics/*.md                          │
│  → .agentflow/specs/stories/*.md                        │
│                                                         │
│  PO Agent validates backlog               Sonnet        │
│  ✓ No circular dependencies                             │
│  ✓ All AC defined                                       │
│  ✓ All stories aligned with PRD + architecture          │
│                            ◄── Human approves backlog   │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│  PHASE 4 — PARALLELIZATION CHOICE                       │
│                                                         │
│  Human chooses one:                                     │
│                                                         │
│  [A] Single Fullstack Agent                             │
│      One agent, all stories, sequential                 │
│                                                         │
│  [B] 1 Frontend + 1 Backend Agent                       │
│      Two parallel tracks, one of each                   │
│                                                         │
│  [C] N Frontend + M Backend Agents                      │
│      Multiple parallel tracks, stories grouped          │
│      into workstreams by dependency                     │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│  PHASE 5 — DEVELOPMENT                                  │
│  Dev agents run per story (Sonnet)                      │
│                                                         │
│  For each story:                                        │
│  1. Read story + contracts                              │
│  2. Write tests first (TDD — Red/Green/Refactor)        │
│  3. Implement against contracts / mocks                 │
│  4. Mark acceptance criteria ✅ / ⚠️ / 🔴              │
│  5. Run security & privacy checklist                    │
│  6. Commit → Push → Open PR                             │
│                                                         │
│  ⚠️  Drift detected?                                    │
│      → Log drift proposal in story file                 │
│      → Await human approval                             │
│      → PO Agent assesses impact                         │
│      → Human approves or rejects                        │
│      → Continue                                         │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│  PHASE 6 — POST-STORY ALIGNMENT SWEEP                   │
│  PO Agent runs after EVERY completed story   Sonnet     │
│                                                         │
│  Checks:                                                │
│  ✓ Future stories still valid?                          │
│  ✓ Past stories still correct?                          │
│  ✓ API contracts still accurate?                        │
│                                                         │
│  Results appended to story file.                        │
│  Any misalignment → flag to human before next story.   │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│  PHASE 7 — QA & EPIC SIGN-OFF                           │
│  QA Agent validates entire Epic              Sonnet     │
│                                                         │
│  Checks:                                                │
│  ✓ All AC covered                                       │
│  ✓ All drift proposals resolved                         │
│  ✓ Contracts compliant (FE mock = BE response)          │
│  ✓ Integration sync points cleared                      │
│  ✓ PRD intent fully delivered                           │
│                                                         │
│  QA report appended to Epic file.                       │
│  BLOCKER issues must resolve before sign-off.           │
│                            ◄── Human signs off Epic     │
└─────────────────────────────────────────────────────────┘
```

---

## Phase 0 — Starting a Project

### Is this a new project or an existing one?

The PRD Agent will ask you this first. Your answer determines the path.

#### Greenfield (New Project)
Jump straight to Phase 1. The PRD Agent will interview you about what you want to build.

#### Brownfield (Existing Project)
The **Codebase Audit Agent** runs first. It reads your existing code and produces `.agentflow/docs/current-state.md` — a plain-English map of what already exists. Then the PRD Agent uses that context to interview you about what you want to *add or change*.

> This order matters. Understanding what exists before planning what's next prevents re-speccing things that are already built and ensures new work fits with existing patterns.

---

## Phase 1 — Discovery (PRD Agent)

**Model:** Opus | **Output:** `.agentflow/docs/prd.md`

The PRD Agent interviews you one question at a time. Don't rush this. The questions cover:
- What problem are you solving, and for whom?
- Who are your users?
- What are the core features?
- What does success look like?
- What's out of scope?
- Any risks or unknowns?

For brownfield projects, the questions focus on *what's changing* rather than rebuilding the entire picture.

**You must explicitly approve the PRD** before anything else happens. Say "Approved" when you're satisfied.

> ⚠️ The PRD is locked after approval. Changes after this point require a formal drift proposal reviewed by the PO Agent.

---

## Phase 2 — Architecture (Architect Agent)

**Model:** Opus | **Output:** `.agentflow/docs/architecture.md` + `.agentflow/specs/contracts/*.md`

The Architect Agent reads your approved PRD and:
1. Confirms or proposes a tech stack
2. Designs the system components and data models
3. Defines **API contracts** — the precise interface between frontend and backend

API contracts are the most critical output of this phase. They allow frontend and backend agents to work in parallel without waiting for each other. The frontend builds against contract-defined mocks; the backend implements the real endpoints. Both are working from the same specification.

**You must explicitly approve the architecture** before planning begins.

---

## Phase 3 — Planning (PM Agent + PO Agent)

**Models:** PM = Opus, PO = Sonnet | **Output:** `.agentflow/specs/epics/*.md`, `.agentflow/specs/stories/*.md`

### PM Agent
Reads the PRD and architecture to create:
- **Epics** — major feature areas (e.g., "User Authentication", "Dashboard", "Billing")
- **Stories** — individual units of work within each Epic, each with:
  - A clear user story statement
  - 3–7 testable acceptance criteria
  - Domain classification (Frontend / Backend / Fullstack)
  - Explicit dependencies on other stories
  - Workstream assignment — grouped in Phase 2 after you choose your parallelization mode

> **Two-phase workflow:** The PM Agent creates all Epics and Stories first, then pauses. After you choose your parallelization mode in Phase 4, the PM Agent runs a second pass to assign workstream groupings. You don't need to do anything differently — the Orchestrator handles the handoff.

### PO Agent
Validates the entire backlog before a single line of code is written:
- No circular dependencies
- All acceptance criteria are testable
- Every story aligns with the PRD and architecture
- Parallelization groupings are dependency-safe

**You must approve the backlog** before development begins.

---

## Phase 4 — Choosing Your Parallelization Mode

After the backlog is approved, you choose how to run your development agents.

### Option A — Single Fullstack Agent
```
[Fullstack Agent]
  Story 1 → Story 2 → Story 3 → ...
```
Best for: solo developers, small projects, tightly coupled frontend/backend work.

One agent handles everything — UI, API, database — story by story, in order.

---

### Option B — 1 Frontend + 1 Backend Agent
```
[Frontend Agent]  Story 1-FE → Story 2-FE → Story 3-FE
[Backend Agent]   Story 1-BE → Story 2-BE → Story 3-BE
                                    ↕
                          Integration sync points
```
Best for: most projects. Solid speed boost with manageable coordination.

Frontend builds against API contract mocks. Backend implements the real APIs. They sync at defined integration points.

---

### Option C — N Frontend + M Backend Agents
```
[FE Agent 1]  WS-FE-1: Story A → Story B
[FE Agent 2]  WS-FE-2: Story C → Story D
[BE Agent 1]  WS-BE-1: Story E → Story F
[BE Agent 2]  WS-BE-2: Story G → Story H
```
Best for: larger Epics with many independent stories.

Stories are grouped into **workstreams** by dependency. Stories that share state or components are in the same workstream. Independent workstreams run in parallel.

> The PM Agent handles workstream grouping automatically based on your chosen agent counts.

---

## Phase 5 — Development (Dev Agents)

**Model:** Sonnet | All dev agents follow the same core loop:

### The Story Loop
```
1. Read story + referenced contracts
         ↓
2. Write failing tests for each AC (TDD Red)
         ↓
3. Implement to make tests pass (TDD Green)
         ↓
4. Refactor while keeping tests green
         ↓
5. Run security & privacy checklist
         ↓
6. Mark each AC: ✅ Done / ⚠️ Partial / 🔴 Drift
         ↓
7. Commit → Push → Open PR
         ↓
8. Notify PO Agent → alignment sweep runs
```

### When Drift Is Detected
If implementation reveals the spec is wrong, incomplete, or impossible:

```
Dev Agent detects issue
         ↓
Logs drift proposal in story file
(stops work on affected AC only)
         ↓
PO Agent assesses impact on all stories
         ↓
Human reviews and approves or rejects
         ↓
If approved: spec updates, dev continues
If rejected: dev finds alternative approach
```

> Dev agents **never** implement a spec change without human approval. No exceptions.

### TDD is Non-Negotiable
Every acceptance criterion requires a test written **before** the implementation. No test = not done.

### Security & Privacy Checklist
Any story touching user input, authentication, or personal data must complete the security checklist before being marked complete. See individual agent files for the full checklists.

---

## Phase 6 — Post-Story Alignment Sweep (PO Agent)

**Model:** Sonnet | Runs automatically after every completed story.

After each story is marked complete, the PO Agent checks the entire backlog:

| Check | What it looks for |
|---|---|
| Forward alignment | Does this story's implementation affect any future story's assumptions? |
| Backward alignment | Does this completion change the correctness of any prior story? |
| Contract alignment | Is the API contract still accurate after this story? |
| Cross-Epic contract check | After each Epic: do contracts used in future Epics still hold? |

Results are appended to the completed story file. If misalignment is found, affected stories are flagged before the next story begins.

> This is the immune system of the framework. Small misalignments caught early cost almost nothing to fix. The same misalignment caught at QA or in production is expensive.

---

## Phase 7 — QA & Epic Sign-Off (QA Agent)

**Model:** Sonnet | Runs when all stories in an Epic are complete.

The QA Agent performs a final validation sweep across the entire Epic:

- Test coverage at the right level — no duplication, no gaps
- Every AC is covered and approved (partial ACs without approved drift = blocker)
- Security checklists completed by dev agents
- All drift proposals resolved
- Frontend mocks match real backend responses
- Integration sync points are cleared
- Accessibility (WCAG 2.1 AA) and responsive design validated
- The Epic's implementation actually delivers the PRD's intent

A QA report is appended to the Epic file. Issues are classified:
- **BLOCKER** — must be fixed before sign-off
- **MAJOR** — should be fixed, review required
- **MINOR** — documented, may be deferred

**You sign off the Epic** after all BLOCKERs are resolved.

---

## Git & PR Workflow

Every completed story results in:

```
Branch:  feature/STORY-[ID]-[story-title]
Commit:  plain-English description of what changed (STORY-[ID])
         Casual style — no feat: prefix, no conventional commits format.
PR:      Opens using .agentflow/templates/pr-template.md
         → Story reference
         → What was built (plain English)
         → Screenshots for UI changes
         → TDD confirmation
         → Security checklist (if applicable)
```

The PR link is recorded in the story file. Reviewers can trace every PR back to its story, acceptance criteria, and alignment sweep results.

---

## Model Tier Quick Reference

| Agent | Model | Why |
|---|---|---|
| **Orchestrator** | **Opus** | Single human interface — must reason, route, and communicate across the full system |
| PRD Agent | **Opus** | Nuanced human conversation, the entire foundation |
| Architect Agent | **Opus** | Technical trade-offs, precise API contracts |
| PM Agent | **Opus** | Story decomposition — the instruction set for all dev agents |
| UI/UX Designer Agent | **Opus** | Design decisions, accessibility judgment, creative reasoning |
| Codebase Audit Agent | **Sonnet** | Code comprehension + synthesis |
| PO Agent | **Sonnet** | Systematic validation + drift judgment |
| Frontend Dev Agent | **Sonnet** | TDD + accessibility + security + implementation |
| Backend Dev Agent | **Sonnet** | TDD + security + implementation (parallelizable) |
| Fullstack Dev Agent | **Sonnet** | TDD + security + full-stack implementation |
| QA Agent | **Sonnet** | Contract + accessibility + alignment verification |
| DevOps Agent | **Sonnet** | CI/CD setup, environment configuration |
| Documentation Agent | **Sonnet** | Synthesis of specs into human-readable docs |
| Micro-tasks / simple sweeps | **Haiku** | Mechanical execution with zero ambiguity |

> The cost principle: Opus tokens flow into the planning layer once. Sonnet tokens execute in parallel across many agents. The better the Opus output, the cheaper and faster everything downstream becomes.

---

## File Structure Reference

```
your-project/
├── .agentflow/                   ← All agent context lives here
│   ├── WORKFLOW.md               ← You are here
│   │
│   ├── agents/                   ← Agent persona files
│   │   ├── orchestrator-agent.md     Opus  ← START HERE
│   │   ├── prd-agent.md              Opus
│   │   ├── codebase-audit-agent.md   Sonnet
│   │   ├── architect-agent.md        Opus
│   │   ├── uiux-designer-agent.md    Opus
│   │   ├── pm-agent.md               Opus
│   │   ├── po-agent.md               Sonnet
│   │   ├── frontend-dev-agent.md     Sonnet
│   │   ├── backend-dev-agent.md      Sonnet
│   │   ├── fullstack-dev-agent.md    Sonnet
│   │   ├── qa-agent.md               Sonnet
│   │   ├── devops-agent.md           Sonnet
│   │   └── documentation-agent.md   Sonnet
│   │
│   ├── templates/                ← Document templates
│   │   ├── prd-template.md
│   │   ├── architecture-template.md
│   │   ├── epic-template.md
│   │   ├── story-template.md
│   │   ├── test-setup-story-template.md
│   │   ├── api-contract-template.md
│   │   └── pr-template.md
│   │
│   ├── intake/                   ← Drop reference files here before starting
│   │   └── README.md
│   │
│   ├── docs/                     ← Generated per project (agent context)
│   │   ├── intake/               (files routed here after processing)
│   │   ├── current-state.md      (brownfield only)
│   │   ├── prd.md
│   │   ├── pmf.md
│   │   ├── architecture.md
│   │   ├── design-system.md
│   │   ├── wireframes/
│   │   ├── environments.md
│   │   ├── secrets.md
│   │   └── devops.md
│   │
│   ├── specs/                    ← Living spec documents
│   │   ├── epics/
│   │   │   └── EPIC-[N]-[name].md
│   │   ├── stories/
│   │   │   └── STORY-[EPIC-N]-[N]-[name].md
│   │   └── contracts/
│   │       └── [domain]-contract.md
│   │
│   └── config/                   ← Runtime config (written by Orchestrator)
│       ├── project-state.md
│       ├── parallelization.md
│       ├── board.md
│       └── board.html
│
├── .claude/commands/             ← Claude Code commands (set up by installer)
│   ├── rex.md
│   └── new-story.md
│
├── .cursor/rules/                ← Cursor rules (set up by installer)
│
├── .gitattributes                ← Strips .agentflow/ on merge to main (auto-created)
│
├── docs/                         ← User-facing docs (generated by Documentation Agent)
│   ├── api/
│   ├── user-guide.md
│   └── onboarding.md
│
├── README.md                     ← Project README (generated by Documentation Agent)
│
└── [your app code]
```

---

## Agent Quick Reference

| Agent | Summoned by | Produces | Human Approval |
|---|---|---|---|
| **Orchestrator** | You (always) | Team assembly, workflow management | N/A — it IS the interface |
| Codebase Audit | Orchestrator (brownfield) | `.agentflow/docs/current-state.md` | No |
| PRD | Orchestrator | `.agentflow/docs/prd.md` | **Yes** |
| Architect | Orchestrator | `.agentflow/docs/architecture.md`, contracts | **Yes** |
| UI/UX Designer | Orchestrator (parallel w/ Architect) | `.agentflow/docs/design-system.md`, wireframes | **Yes** |
| PM | Orchestrator | Epics, Stories | **Yes** |
| PO (pre-dev) | Orchestrator | Validated backlog | **Yes** |
| DevOps | Orchestrator (parallel w/ Epic 1) | CI/CD, `.agentflow/docs/` env docs | No |
| Dev Agents | Orchestrator | Code, PR, updated story | Drift proposals only |
| PO (sweep) | Orchestrator (auto) | Alignment sweep in story file | No |
| QA | Orchestrator | QA report in Epic file | **Yes (sign-off)** |
| Documentation | Orchestrator (final Epic) | README, API docs, user guide, migration guide (brownfield) | No |

---

## Frequently Asked Questions

**Q: What if the PRD needs to change after development has started?**
Any proposed change must go through the drift proposal process. The dev agent logs it, the PO Agent assesses impact, and the human approves. The change then propagates to all affected stories and contracts before work continues.

**Q: Can I skip the PO Agent's alignment sweep to go faster?**
Not recommended. The sweep is lightweight and runs automatically. Skipping it removes the early-warning system that makes brownfield and parallel development safe. A missed alignment issue that reaches QA costs significantly more to fix.

**Q: What if I want to add a story mid-Epic?**
Add the story using `.agentflow/templates/story-template.md`, assign it to an Epic, and run the PO Agent's pre-dev validation on the new story only. Make sure to check its dependencies against existing stories.

**Q: Do the dev agents merge PRs?**
No. Dev agents open PRs and link them in the story file. Merging is a human decision.

**Q: What's the difference between a MAJOR and a BLOCKER in the QA report?**
A BLOCKER means the feature doesn't work correctly or safely as specified — it cannot ship. A MAJOR means there's a meaningful issue that should be fixed but might be acceptable to defer with a documented plan.

**Q: What goes in the .agentflow/intake/ folder?**
Drop anything you want Rex to know about before you start — screenshots of competitor apps, brand guidelines, existing feature specs, API docs from third-party integrations, rough sketches. Rex scans this folder at kickoff and routes each file to the right agent. You can also share files directly in the chat and Rex will save them automatically.
