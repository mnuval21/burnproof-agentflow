# Story: Testing Infrastructure Setup

> ⚠️ **This story must be the first story in the first Epic of every project.**
> No feature tests can be written until this story is complete.
> For brownfield projects, check `docs/current-state.md` first — if a testing setup already exists, mark this story complete and document what's already there.

---

**Story ID:** STORY-[EPIC-1]-00
**Epic:** EPIC-1 — [First Epic Name]
**Domain:** FULLSTACK
**Workstream:** WS-FS (or assigned to first available agent)
**Status:** PLANNED
**Assigned Agent:** Fullstack Dev Agent (or Backend Dev Agent)

---

## User Story
As a developer, I want a testing infrastructure in place so that every acceptance criterion can be verified with an automated test before a story is marked complete.

---

## Engagement Impact
Infrastructure story — not user-facing, but gates all TDD work across the project. Without this, no AC can be tested and the entire quality system breaks down.

---

## Context
This project currently has no test framework configured. Before any feature work begins, the test runner, component testing library, and E2E framework must be installed and verified working with a single passing test each.

**PRD Reference:** N/A — engineering infrastructure
**Architecture Reference:** Tech stack section of `docs/architecture.md`

---

## Dependencies
| Type | Story ID | Description |
|---|---|---|
| `blocks` | All feature stories | No story can write feature tests until this is complete |

---

## Acceptance Criteria

- [ ] AC-01: Vitest is installed and configured — **Test level:** Unit (self-validating: `vitest run` exits 0)
- [ ] AC-02: React Testing Library is installed and a smoke test renders one existing component without errors — **Test level:** Component
- [ ] AC-03: Playwright is installed and configured for E2E — **Test level:** E2E (self-validating: `playwright test` runs against local dev server)
- [ ] AC-04: All three test commands are added to `package.json` scripts:
  - `test` → runs Vitest unit + component tests
  - `test:e2e` → runs Playwright tests
  - `test:coverage` → runs Vitest with coverage report
- [ ] AC-05: CI pipeline runs `test` and `test:e2e` on every PR (coordinate with DevOps Agent if active)

**Test level for AC-04 and AC-05:** Integration (verify scripts work end-to-end)

---

## Stack-Specific Setup Notes

### Remix + React + TypeScript (BurnProof stack)
```bash
# Vitest + React Testing Library
npm install -D vitest @vitejs/plugin-react jsdom @testing-library/react @testing-library/user-event @testing-library/jest-dom

# Playwright
npm install -D @playwright/test
npx playwright install
```

**`vitest.config.ts`:**
```ts
import { defineConfig } from 'vitest/config'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: ['./tests/setup.ts'],
  },
})
```

**`tests/setup.ts`:**
```ts
import '@testing-library/jest-dom'
```

**Smoke test** (`tests/smoke.test.tsx`):
```tsx
import { render, screen } from '@testing-library/react'
import { describe, it, expect } from 'vitest'

describe('Testing infrastructure', () => {
  it('renders without crashing', () => {
    render(<div>Test setup working ⚡</div>)
    expect(screen.getByText('Test setup working ⚡')).toBeInTheDocument()
  })
})
```

---

## Implementation Notes
*(Updated by dev agent on completion)*

---

## Pull Request
- **PR Link:** [URL]
- **Branch:** `feature/STORY-[EPIC-1]-00-test-setup`
- **Status:** OPEN | MERGED

---

## Definition of Done
- [ ] All three test runners installed and passing
- [ ] Scripts in package.json confirmed working
- [ ] CI pipeline updated (if DevOps Agent active)
- [ ] Status set to COMPLETE
