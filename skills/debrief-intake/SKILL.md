---
name: debrief-intake
description: "Turn a Plaud voice recording — a client meeting or a solo brainstorm — into a repo-aware brief committed to the current repo, checked against its roadmap and open issues. Use when asked to debrief a recording, 'process the meeting notes', 'turn this recording into a brief', or when a Plaud recording is named alongside a project."
---

# debrief — intake

Turn one named recording into a **brief** for the repo you're standing in: cleaned up, classified
against that project's own taxonomy, and checked against what's already planned. Then stop —
**filing the work is a separate skill with its own gate** (`debrief-issues`).

Read `plaud-shared` first if no Plaud tool has been called yet this session.

## Scope

- **The current repo only** — whatever the shell is in. Never reach across repos, and never guess
  which project a recording belongs to. If the user hasn't made it obvious, ask.
- **One explicitly named recording** — an ID, or an unambiguous reference the user gives ("the 07-23
  meeting"). Never sweep an archive looking for work: a voice archive holds personal, legal, and
  family material that has no business entering a project pipeline.

## Preconditions

1. Confirm you're inside a git repo (`git rev-parse --show-toplevel`). If not, stop and say so.
2. Read `docs/intake/PROFILE.md`. **If it's missing, stop and offer `debrief-profile`.** Without it
   you're guessing at the project's vocabulary, taxonomy, and constraints, and the brief degrades
   into a nicely formatted restatement of the transcript.
3. Check `docs/intake/` for a brief whose frontmatter `recording_id` already matches. If one exists,
   say so and ask whether to update it rather than writing a second.

## Steps

1. **Fetch the recording.**
   - `get_file` for metadata — name, `created_at`, duration, speaker count.
   - `get_transcript` for content. Prefer the polished block where it exists; it is markedly better
     input than raw. (CLI equivalent: `plaud transcript <id> --polished`.)
   - Write the transcript **to local scratch only** — never into the repo, not even temporarily.

2. **Pick the mode**, and say which you picked:
   - **meeting** — more than one speaker → `templates/brief-meeting.md`
   - **brainstorm** — one voice → `templates/brief-brainstorm.md`
   - Ambiguous, such as one person recapping a call they just had? Ask.

   The templates sit alongside this skill at `templates/` (a symlink into the debrief repo). If that
   path isn't readable, resolve it with `readlink -f ~/.claude/skills/debrief-intake` and look two
   levels up.

3. **Load the project's context.** This is what makes the brief worth more than a transcript:
   - `docs/intake/PROFILE.md` — role, framing facts, vocabulary, taxonomy, constraints
   - `CLAUDE.md` and `ROADMAP.md` — how the project works, and what's planned
   - `gh issue list --state open --limit 100 --json number,title,labels` — what's already tracked
   - `gh pr list --state merged --limit 20 --json number,title` — what just shipped, so you don't
     report a solved problem as a new one

4. **Read the note.** Find the core points; strip filler and false starts; make implicit assumptions
   explicit; correct mangled terms using the profile's vocabulary table. **Do not invent specifics** —
   a gap is an open question, not something to fill with a plausible guess. Preserve the reasoning in
   the speaker's own words where it carries the "why"; that's the part worth keeping.

5. **Classify each distinct item** using the profile's taxonomy. One note routinely holds several
   unrelated items — separate them, and order by importance rather than by when they were said.

6. **For a meeting, build the delta.** This is the section that earns the tool its keep:
   - **Already planned** — cite the issue number or roadmap line. An uncited claim that something is
     already planned is worse than no claim at all.
   - **New scope** — asked for, tracked nowhere. These become the candidate issues.
   - **Changed scope** — what moved, and **what it displaces**. That's the part that costs money.
   - **Ruled out** — declined or parked, with the reason.

   Then capture decisions (with the reasoning behind them), commitments (who · what · by when —
   "unstated" is a valid answer), and risks.

7. **For a brainstorm**, one block per item per the skeleton, and put anything half-formed in the
   **parking lot**. Forcing a vague thought into an issue produces a ticket nobody can act on and
   loses the actual thought.

8. **Flag sensitive content** under `⚠ Sensitive — review before commit`: rates, payment terms,
   personal or medical detail, third-party confidences, unflattering characterisations. **Surface it,
   don't silently drop it** — quiet filtering hides a judgment call that belongs to the human.

9. **Write the brief** to `docs/intake/YYYY-MM-DD-<slug>.md`, frontmatter first with `recording_id`
   populated. The committed briefs are the ledger, and that field is what makes a re-run idempotent.

10. **Land it by PR** — never a direct commit to the default branch:
    ```bash
    git checkout -b docs/intake-<slug>
    git branch --show-current          # confirm: an aborted checkout leaves you on the default branch
    git add docs/intake/<file>.md
    git commit && git push -u origin HEAD
    gh pr create --assignee <owner> --label documentation --body "…"
    ```
    Wire the PR up completely per the repo's conventions — assignee, labels, milestone, board.

11. **Show the user the brief**, and point at the two things that need their eye: the `⚠ Sensitive`
    section, and anything left as an open question.

## Hard rules

- **Never create issues here.** Writing a brief and filing work carry different risk; the second has
  its own skill and its own approval gate.
- **Raw transcripts never enter a repo.** Local scratch only.
- **Never batch.** One named recording per run.
- **Cite, don't assert.** "Already planned" needs an issue number behind it.
- **Never invent** a decision, a commitment, a date, or a specific that wasn't in the recording.
- **Confirm the branch before committing.** An aborted checkout has silently left work on the default
  branch before.
