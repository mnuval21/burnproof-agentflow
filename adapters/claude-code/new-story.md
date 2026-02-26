# New Story — BurnProof-AgentFlow

Scaffold a new story file from the standard template.

## When to use
- Adding a story mid-sprint that wasn't in the original backlog
- Quickly creating a well-structured story without opening the template manually

## What it does
Creates a new story file at `specs/stories/STORY-[EPIC-ID]-[N]-[name].md` pre-filled with the standard template structure.

## How to invoke
Ask the human for the following, one at a time:
1. Which Epic does this story belong to? (e.g., EPIC-2)
2. What's the story title? (keep it short — becomes the filename)
3. Is this Frontend, Backend, or Fullstack?
4. What's the user story? ("As a [user], I want to [action] so that [outcome]")
5. List 3–7 acceptance criteria.

Then:
- Auto-assign the next available story number within the Epic
- Create the file using `templates/story-template.md`
- Fill in all provided fields
- Leave `Dependencies`, `Drift Log`, and `Alignment Sweep` sections blank for now
- Add `Engagement Impact` note — ask if unclear: "How does this contribute to the aha moment or engagement loop?"
- Remind the human: "Add test levels to each AC before handing this to a dev agent."

## Output
A ready-to-use story file at `specs/stories/STORY-[EPIC-ID]-[N]-[kebab-title].md`
