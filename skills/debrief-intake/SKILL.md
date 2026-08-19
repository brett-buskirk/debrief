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

   **Mundane non-project conversation is not carried** — the weekend, dinner, small talk. It goes the
   way filler goes: dropped without ceremony, because it is noise rather than a confidence. Do not
   route it to the sensitive block; naming "personal detail" there to describe someone's dinner gives
   trivia a permanent home in a tracked file and buries the real flags in chatter. The distinction is
   sensitivity, not personal-ness — see step 8.

   **In a meeting, judge a remark on relevance, not on register.** The rule above is safe for a solo
   brainstorm, where personal-sounding talk really is noise. A client call is the opposite: capacity,
   absence, reorgs, budget, and timing arrive as small talk and are often the most decision-relevant
   thing said. "We're slammed since the reorg" is not chatter — it is the reason a date moves, and the
   delta's **Changed scope** section is worthless without it. Carry the substance, drop the pleasantry.
   Where such a remark is also personal to a third party, step 9 already applies: paraphrase it.

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
   personal detail that is genuinely sensitive — health, family, legal, financial — third-party
   confidences, unflattering characterisations.

   **Sensitivity is the trigger, not personal-ness.** "A co-founder is unwell" is a flag; what
   someone ate is not, and step 4 already dropped it. When a personal subject is genuinely
   ambiguous, flag it — over-flagging costs a line the human deletes, while under-flagging is
   the silent filter non-negotiable 5 exists to prevent.

   **Name the category; never quote the content.** "Commercial terms were discussed and are excluded"
   is the right shape. Reproducing the terms in order to flag them defeats the flag — the brief is a
   tracked file, and a quote in the sensitive section is just as committed as a quote anywhere else.
   Naming it keeps the omission a visible decision rather than a silent filter, which is the whole
   point, without the content landing in the repo.

   Two categories are absolute, not judgment calls: **anything the repo's own docs designate as
   confidential** (follow the profile's "Where things go"), and **anything covered by a positioning
   or personal-history rule** in `CLAUDE.md`. Those don't get quoted even to be flagged.

9. **Paraphrase third parties.** Where someone other than the note's author is in the room, their
   words are their information as much as the project's. Quote the author freely — their reasoning is
   the part worth preserving — but render other participants in paraphrase, and keep any
   characterisation of a third party's commercial position out of a tracked file entirely. A private
   repo can be made public later; a quote written today has to survive that.

10. **Write the brief** to `docs/intake/YYYY-MM-DD-<slug>.md`, frontmatter first with `recording_id`
    populated. The committed briefs are the ledger, and that field is what makes a re-run idempotent.

    **Name the file for what's in scope, not for what the recording is called.** A recording titled
    for its commercial half shouldn't put that in a path that lands in git history.

    **A short brief is a correct brief.** A call can be mostly out of scope for the repo you're in;
    say so in a scope note near the top and let the brief be as thin as the material warrants.
    Inflating twenty minutes of relevant conversation into a full-looking document is a failure, not
    thoroughness.

11. **Land it by PR** — never a direct commit to the default branch:
    ```bash
    git checkout -b docs/intake-<slug>
    git branch --show-current          # confirm: an aborted checkout leaves you on the default branch
    git add docs/intake/<file>.md
    git commit && git push -u origin HEAD
    gh pr create --assignee <owner> --label documentation --body "…"
    ```
    Wire the PR up completely per the repo's conventions — assignee, labels, milestone, board.

12. **Show the user the brief**, and point at the two things that need their eye: the `⚠ Sensitive`
    section, and anything left as an open question.

## Hard rules

- **Never create issues here.** Writing a brief and filing work carry different risk; the second has
  its own skill and its own approval gate.
- **Raw transcripts never enter a repo.** Local scratch only.
- **Never batch.** One named recording per run.
- **Name sensitive content, never quote it.** Flagging a confidence by reproducing it commits it.
- **Paraphrase third parties.** Quote the note's author; render everyone else in your own words.
- **Cite, don't assert.** "Already planned" needs an issue number behind it.
- **Never invent** a decision, a commitment, a date, or a specific that wasn't in the recording.
- **Confirm the branch before committing.** An aborted checkout has silently left work on the default
  branch before.
