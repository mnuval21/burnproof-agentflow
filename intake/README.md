# Intake Folder

Drop any reference files here **before starting Rex**. Rex will read everything in this folder at kickoff and route it to the right agents.

## What to put here

| File type | Examples | Goes to |
|---|---|---|
| Screenshots / mockups | Competitor app screenshots, rough sketches, Figma exports | UI/UX Designer Agent |
| Brand assets | Logo files, brand guidelines PDF, color swatches | UI/UX Designer Agent |
| Inspiration images | "I want it to feel like this" screenshots | UI/UX Designer Agent |
| Existing documentation | Old PRDs, feature specs, meeting notes | PRD Agent |
| Technical docs | API docs from third parties, integration guides | Architect Agent |
| Research | User research, survey results, analytics exports | PRD Agent |

## Naming tips
Use descriptive names so Rex knows what each file is at a glance:
- `brand-guidelines.pdf` ✅
- `competitor-app-screenshot.png` ✅
- `existing-feature-spec.md` ✅
- `image1.png` ❌

## Files shared in chat
If you share a file or image directly in the chat during a session, Rex will save a copy here automatically with a descriptive name so it's available in future sessions.

## After a project starts
Files processed by agents are moved to `docs/intake/[filename]` for permanent storage alongside the project documentation.
