---
name: debrief-profile
description: "Create or refresh a repo's debrief intake profile (docs/intake/PROFILE.md) by reading the project's own docs, labels, and milestones. Use when setting debrief up for a repo, when asked to 'create the intake profile' or 'set up debrief here', or when debrief-intake reports the profile is missing."
---

# debrief — profile

Draft `docs/intake/PROFILE.md` for the repo you're standing in: the file that teaches `debrief` how
to read a voice note about **this** project. You produce a strong first draft from what the repo
already documents, then hand it back for the parts only a human knows.

## Scope

The current repo only. The profile describes one project; a shared or generic profile would defeat
the point of having one.

## Steps

1. **Confirm the repo** (`git rev-parse --show-toplevel`) and check whether `docs/intake/PROFILE.md`
   already exists. If it does, this is a **refresh**: read it first and preserve every hand-written
   section — especially vocabulary and north stars. Propose changes rather than overwriting.

2. **Read what the project already says about itself:**
   - `CLAUDE.md` — the richest source. Non-negotiables, architecture, conventions, gotchas.
   - `README.md` — what it is and who it's for.
   - `ROADMAP.md` — the current phase, and what's deliberately not being built.
   - `ARCHITECTURE.md` or `docs/DESIGN.md` if present.
   - The manifest (`package.json`, `Cargo.toml`, `requirements.txt`, playbooks, charts) for the stack.

3. **Read the repo's actual wiring**, so the taxonomy maps to labels that exist:
   ```bash
   gh label list --limit 100
   gh api repos/:owner/:repo/milestones --jq '.[].title'
   gh repo view --json owner,isPrivate,defaultBranchRef
   ```
   Note whether this is one of Brett's own repos (full estate wiring, Estate board) or someone
   else's (local conventions only, no estate board).

4. **Fill the template** at `templates/PROFILE.md` — alongside this skill, via symlink; if it isn't
   readable, resolve with `readlink -f ~/.claude/skills/debrief-profile` and look two levels up.
   Section by section:
   - **Role, Project context** — draft confidently from the docs. Five to eight framing facts, the
     architecture in a line, and the paths that come up constantly.
   - **Classification** — build the type taxonomy from what this project actually produces. A game
     has content and balance; an infra repo has drift and runbooks; a library has API surface. Map
     each to a **real** label from step 3.
   - **Specifics to extract** — per type, the details needed to act: which file, which host, which
     number, repro steps.
   - **Constraints / north stars** — lift these from `CLAUDE.md`. **Quote, don't paraphrase** where
     the wording is load-bearing, and **never invent one**. If the repo doesn't state its
     non-negotiables, leave a marker rather than guessing at them.
   - **Vocabulary** — seed it with the project nouns transcription reliably mangles: the repo name,
     tool names, coined terms, anything with unusual spelling. This table is the cheapest accuracy
     win in the file, and it grows every time a brief gets a term wrong.
   - **Where things go** — labels, milestone, board, and `docs/intake/` for briefs, per step 3.

5. **Mark what you couldn't know.** Anywhere the repo's own docs don't answer the question, leave an
   explicit `<TODO: …>` rather than a plausible invention — a confidently wrong profile is worse than
   an obviously incomplete one, because every future brief inherits the error silently.

6. **Land it by PR:**
   ```bash
   git checkout -b docs/intake-profile
   git branch --show-current          # an aborted checkout leaves you on the default branch
   git add docs/intake/PROFILE.md && git commit && git push -u origin HEAD
   gh pr create --assignee <owner> --label documentation --body "…"
   ```

7. **Hand back with a short list** of exactly which sections need the human's eye — normally
   **Vocabulary**, **Constraints / north stars**, and **Definition of done**, since those carry the
   knowledge that isn't written down anywhere in the repo.

## Hard rules

- **Never invent a north star, a constraint, or a "done" criterion.** Lift them from the repo or mark
  them `<TODO>`.
- **Never invent a label or milestone** — the taxonomy maps to what exists today.
- **On a refresh, never silently overwrite hand-written sections.** Propose the diff.
- The profile is a starting point, not an authority. Say so when handing it back.
