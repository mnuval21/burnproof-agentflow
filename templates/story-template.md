# Story: [Story Title]

**Story ID:** STORY-[EPIC-N]-[N]
**Epic:** EPIC-[N] — [Epic Name]
**Domain:** FRONTEND | BACKEND | FULLSTACK
**Workstream:** WS-FE-[N] | WS-BE-[N] | WS-FS
**Status:** PLANNED | IN_PROGRESS | COMPLETE
**Assigned Agent:** [Agent Type]
**Created:** [DATE]
**Last Updated:** [DATE]

---

## User Story
> As a [user type], I want to [action] so that [outcome].

---

## Engagement Impact
> How does this story contribute to the aha moment, engagement loop, or north star metric?

[One sentence — e.g., "This story is on the critical path to the aha moment — without it, users cannot experience core value."]

---

## Context
> Why does this story exist? What does it connect to?

[Brief context linking this story to its Epic and PRD section]

**PRD Reference:** [Section]
**Architecture Reference:** [Section or component]
**API Contracts:** [e.g., `specs/contracts/auth-contract.md` — list all that apply]
**Wireframes:** [e.g., `docs/wireframes/login-screen.md` — list all that apply, FRONTEND stories only]
**Existing code:** [Brownfield only — file paths of existing code this story modifies or extends]

---

## Dependencies

| Type | Story ID | Description |
|---|---|---|
| `blocked_by` | STORY-[X] | [Why this must complete first] |
| `blocks` | STORY-[Y] | [What this story unlocks] |
| `integration_sync` | STORY-[Z] | [When FE and BE must coordinate] |

---

## Acceptance Criteria

> Each criterion must be testable and unambiguous. Each AC must specify its test level before implementation begins.
> Test levels: `Unit` | `Component` | `Integration` | `E2E` | `None`

- [ ] AC-01: [Criterion] — **Test level:** [level]
- [ ] AC-02: [Criterion] — **Test level:** [level]
- [ ] AC-03: [Criterion] — **Test level:** [level]
- [ ] AC-04: [Criterion] — **Test level:** [level]

### Accessibility Criteria *(required for all UI stories)*
- [ ] ACC-01: All interactive elements are keyboard accessible
- [ ] ACC-02: Color contrast meets WCAG 2.1 AA (4.5:1 normal text, 3:1 large text)
- [ ] ACC-03: Layout is functional and usable at 375px (mobile) and 1280px (desktop)
- [ ] ACC-04: Touch targets are minimum 44×44px on mobile

---

## Technical Notes
> Implementation guidance for the assigned agent.

[Notes on approach, constraints, or patterns to follow]

---

## Implementation Progress

*(Updated by the assigned dev agent during implementation)*

| AC | Status | Notes |
|---|---|---|
| AC-01 | ✅ Done / ⚠️ Partial / 🔴 Drift | [Notes] |
| AC-02 | ✅ Done / ⚠️ Partial / 🔴 Drift | [Notes] |
| AC-03 | ✅ Done / ⚠️ Partial / 🔴 Drift | [Notes] |

**Implementation Summary:**
[Brief summary of what was built when story is complete]

---

## Drift Log

*(Entries added by dev agents when spec drift is detected)*

<!--
## Drift Proposal — [DATE]
Criterion/Reference: [AC or contract reference]
Issue: [What's wrong with the current spec]
Proposed change: [What should change]
Impact: [What other stories or contracts this affects]
Status: PENDING_HUMAN_APPROVAL | APPROVED | REJECTED
Resolved: [DATE] by [Human Name]
Notes: [Resolution notes]
-->

---

## Alignment Sweep Results

*(Appended by PO Agent after story completion)*

<!--
## Alignment Sweep — [DATE]
Forward stories affected: [List or "None"]
Backward stories affected: [List or "None"]
Contract drift detected: Yes/No
Action required: None / [Details]
-->

---

## Pull Request
*(Added by dev agent on story completion)*

- **PR Link:** [URL]
- **Branch:** `feature/STORY-[ID]-[title]`
- **Status:** OPEN | MERGED | CLOSED

---

## Definition of Done
- [ ] All AC marked ✅ Done (or drift approved)
- [ ] Drift log entries all resolved
- [ ] Implementation notes complete
- [ ] PO Agent alignment sweep run
- [ ] PR opened and linked above
- [ ] Status set to COMPLETE
