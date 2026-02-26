# Project State
> Rex reads this at the start of every session. Keep it current. One source of truth.

---

## Project
**Name:** [Project name]
**What it is:** [One sentence]
**Repo:** [path or URL]

---

## Team
**Mode:** Greenfield | Brownfield
**Parallelization:** Mode A (Fullstack) | Mode B (1 FE + 1 BE) | Mode C (N FE + M BE)
**Agents active:** [list — e.g., PRD, Architect, UI/UX, PM, PO, 2×FE, 1×BE, QA, DevOps, Docs]

---

## Current Position
**Phase:** [0 Start | 1 Discovery | 2 Architecture | 3 Planning | 4 Para Choice | 5 Dev | 6 PO Sweep | 7 QA]
**Current Epic:** EPIC-[N] — [name] ([X] of [Y] stories done)
**Current Story:** STORY-[ID] — [name] | Status: [In Progress | Blocked | Done]
**Up next:** [what happens after current story]

---

## Approvals Locked
- [ ] PRD — `docs/prd.md`
- [ ] Architecture — `docs/architecture.md`
- [ ] Design — `docs/design-system.md`
- [ ] Backlog — all stories validated by PO
- [ ] Parallelization config — `config/parallelization.md`

---

## Epics
| Epic | Status | Stories Done | QA | Sign-Off |
|---|---|---|---|---|
| EPIC-1 — [name] | In Progress | 2/5 | — | — |
| EPIC-2 — [name] | Planned | 0/4 | — | — |

---

## Open Items
> Anything blocking, pending human input, or flagged for follow-up.

- [ ] [Item — e.g., "Drift proposal on STORY-2-3 pending human approval"]
- [ ] [Item]

---

## Key File Paths
| File | Purpose |
|---|---|
| `docs/prd.md` | Approved PRD |
| `docs/pmf.md` | Aha moment, north star metric |
| `docs/architecture.md` | Approved architecture |
| `docs/design-system.md` | Design system + wireframes |
| `docs/current-state.md` | Codebase audit (brownfield) |
| `specs/epics/` | All Epic files |
| `specs/stories/` | All Story files |
| `specs/contracts/` | API contracts |
| `config/parallelization.md` | Parallelization mode |

---

## Session Log
> One line per session. Most recent at top.

| Date | What happened | Left off at |
|---|---|---|
| [DATE] | [e.g., "Completed STORY-1-3, PO sweep clean, STORY-1-4 in progress"] | STORY-1-4 |
| [DATE] | [e.g., "PRD and architecture approved, backlog created, parallelization set to Mode B"] | Start of Epic 1 |
