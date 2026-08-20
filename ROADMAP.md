# Roadmap

_What's planned for debrief — check items off as they ship._

## v0.1.0 — Foundation

- [x] Intake profile template (`templates/PROFILE.md`) — the generalized per-repo context file
- [x] Brief skeletons — client meeting and brainstorm
- [x] `debrief-profile` skill — draft a repo's profile from its own docs
- [x] `debrief-intake` skill — recording to repo-aware brief
- [x] `debrief-issues` skill — brief to wired issue drafts, dry-run by default
- [x] `install.sh` — symlink the skills into `~/.claude/skills/`
- [x] Proven end to end against one real client meeting (2026-07-23)
- [x] Proven end to end against one real brainstorm — `day-one`, 2026-08-20: brief, two
      issues filed against the repo's own labels, and the issue numbers written back to the
      brief's frontmatter

## v0.2.0 — Round trip

- [ ] Generate the Plaud-side capture template from `PROFILE.md`, so the two renderings of the same
      project context cannot drift apart
- [ ] Migrate `day-one/docs/plaud/` onto the generalized profile (it's the reference implementation)
- [ ] Local index of processed recordings — a fast idempotency check; the committed briefs stay the
      source of truth and the index can be rebuilt from them

## v0.3.0 — Range

- [ ] Multi-recording digest — a week of notes rolled into one brief
- [ ] Commitment tracking across briefs: what was promised, and what actually shipped

## Later

- [ ] Extract a CLI for the deterministic half — fetch, index, and issue wiring — so the workflow
      runs outside Claude Code and under cron
- [ ] Public release — the tree is sanitized of client specifics and the loop has run against
      both a real meeting and a real brainstorm. Flipping visibility is the remaining step.
