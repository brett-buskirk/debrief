---
name: debrief-issues
description: "Draft GitHub issues from a debrief brief — wired to the repo's own conventions (labels, assignee, milestone, board) — show them for approval, and create them only on the user's explicit word. Use after a brief exists and the user says 'make the issues', 'file these', or 'turn the brief into tickets'."
---

# debrief — issues

Turn the **Candidate issues** section of a brief into real, fully-wired GitHub issues. Draft them,
**show them**, and create them only once the user says so. Nothing here fires as a side effect of
anything else.

## Scope

- **The current repo only**, and one brief per run.
- Works from a brief produced by `debrief-intake`. If there isn't one, stop and offer that skill —
  don't improvise issues straight from a transcript, because the delta check against existing work
  is what keeps this from filing duplicates.

## Steps

1. **Read the brief.** Take the path from the user, or find it in `docs/intake/` by `recording_id`.
   Work from its **Candidate issues** section only. Open questions and parking-lot items are
   deliberately not issues — leave them alone.

2. **Detect which conventions apply.** These repos are not all the same:
   - **Brett's own repo** (owner `brett-buskirk`, living under `~/github-repos`) — full estate
     wiring: `--assignee brett-buskirk`, base + scope labels, the current milestone, and the Estate
     board.
   - **Anyone else's repo** — the repo's own conventions win. Read what actually exists:
     ```bash
     gh label list --limit 100
     gh api repos/:owner/:repo/milestones --jq '.[].title'
     ```
     Apply only labels that already exist, never invent one, and **never** add it to an estate board.

3. **Check for duplicates before drafting.** `gh issue list --state all --limit 100 --search "<key
   terms>"`. If something close already exists, say so and propose commenting on it instead of
   opening a second. Report what you skipped and why.

4. **Draft each issue** in this shape, so every one reads the same:

   ```markdown
   **From:** [<brief filename>](<link to the brief in the repo>) — recorded <YYYY-MM-DD>

   <the ask, in plain terms>

   **Why:** <the reason, in the requester's own words where that carries the rationale>

   **Done looks like:** <the acceptance check from the brief>

   <any specifics: file, module, screen, number, repro steps>

   _Drafted by an agent from a voice note; triaged by a human._
   ```

   Every generated issue carries **`needs-triage`** on top of its type label. A machine drafted it;
   a human decides whether it's real.

5. **Dry run — this is the gate.** Print the full plan and stop:

   | # | Title | Labels | Milestone | Board |
   |---|---|---|---|---|
   | 1 | … | `enhancement`, `needs-triage` | v0.2.0 — … | Estate #17 |

   Show each issue body in full underneath. Then ask for a go-ahead. **Do not create anything until
   the user gives one.** "Looks good" on the brief is not approval to file issues.

6. **On approval, create them:**
   ```bash
   gh issue create --title "…" --body-file <file> \
     --assignee brett-buskirk --label "<type>" --label needs-triage --milestone "<milestone>"
   ```
   Then, for Brett's own repos only:
   ```bash
   gh project item-add 17 --owner brett-buskirk --url <issue-url>
   ```
   `item-add` prints nothing on success. Verify rather than assume:
   ```bash
   gh project item-list 17 --owner brett-buskirk --format json --limit 500 \
     --jq '.items[] | select((.repository // "") | test("<repo>"))'
   ```
   (Note the field is `.repository` on the item, not `.content.repository`.) If the call fails on
   scope, the fix is `gh auth refresh -s project`.

7. **Record what was filed.** Update the brief's frontmatter `issues: [...]` with the numbers created,
   and land that edit on the brief's own branch — or a small follow-up PR if the brief has already
   merged. The brief is the ledger; an unrecorded issue breaks the idempotency check on a re-run.

8. **Report back** a short table: issue number, title, labels, and anything you deliberately skipped.

## Hard rules

- **Never create an issue without an explicit go-ahead** for that specific set. Approval doesn't
  carry from a previous run.
- **Everything generated gets `needs-triage`.** No exceptions, however obvious the item looks.
- **Never invent a label or a milestone.** If the right one doesn't exist, say so and let the human
  decide whether to create it.
- **Never file open questions or parking-lot items.** They're marked that way on purpose.
- **Never touch an estate board from someone else's repo.**
- **Never close, merge, or reprioritise** existing issues. Filing is the whole job.
