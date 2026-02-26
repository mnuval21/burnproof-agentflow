## What does this PR do?
<!-- Describe what you built in plain English. Pretend you're explaining it to a teammate over Slack. -->


## Story Reference
- **Story ID:** STORY-[EPIC-N]-[N]
- **Epic:** EPIC-[N] — [Epic Name]
- **Story file:** `specs/stories/STORY-[ID].md`

## Type of change
<!-- Check the one that applies -->
- [ ] New feature
- [ ] Bug fix
- [ ] Refactor (no behavior change)
- [ ] Style / UI update
- [ ] Tests only
- [ ] Documentation

---

## What was built

### Summary
<!-- Bullet points of the main things implemented -->
-
-
-

### Screenshots or recordings
<!-- If this is a UI change, drop a screenshot or screen recording here. This helps reviewers understand what they're looking at. -->

| Before | After |
|---|---|
| _(if applicable)_ | _(screenshot here)_ |

---

## Testing

- [ ] Tests were written **before** implementation (TDD)
- [ ] All new acceptance criteria have a corresponding test
- [ ] All existing tests still pass
- [ ] I tested this manually in the browser / Postman / terminal

### What to test
<!-- Tell the reviewer exactly how to verify this works -->
1.
2.
3.

---

## Security & Privacy
<!-- Only fill this out if your story touched user data, auth, or forms -->

**Does this PR handle user data or authentication?**
- [ ] No — skip this section
- [ ] Yes — checklist below applies

### Backend
- [ ] All user input is validated server-side
- [ ] Parameterized queries used (no SQL injection risk)
- [ ] Passwords are hashed (never stored in plaintext)
- [ ] PII is not exposed in logs or error responses
- [ ] Error messages returned to users are generic

### Frontend
- [ ] No sensitive data stored in `localStorage`
- [ ] No PII or tokens in URL parameters
- [ ] User input is sanitized before rendering
- [ ] Console logs contain no sensitive data

---

## Checklist before requesting review

- [ ] Code does what the story acceptance criteria describe
- [ ] No `console.log` or debug code left in
- [ ] No hardcoded secrets, API keys, or credentials
- [ ] Branch is up to date with `main` (or base branch)
- [ ] PR title follows the format: `feat(STORY-[ID]): [brief description]`

---

## Anything the reviewer should know?
<!-- Anything tricky, a decision you made, a trade-off, or something to pay special attention to -->
