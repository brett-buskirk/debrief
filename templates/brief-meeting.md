---
recording_id: <plaud file id>
recorded: <YYYY-MM-DD>
duration: <e.g. 30m40s>
mode: meeting
repo: <owner/repo>
participants: [<names or speaker labels>]
issues: []   # filled in when issues are created
---

<!--
  Client-meeting brief — the shape `debrief` produces for a multi-speaker recording.
  The frontmatter above stays first in the file: `recording_id` is what makes re-running a
  recording idempotent, and it's why the committed briefs can serve as the ledger.

  The delta section is the point of this format. A recap of what was said is available from any
  transcription tool; what isn't is knowing which half of a request is already on the roadmap and
  which half is new work. Fill "Already planned" from the repo's open issues and ROADMAP, and cite
  the issue numbers — an uncited claim that something is planned is worse than no claim.

  Leave a section out when it's genuinely empty. Never invent a decision, a commitment, or a date
  that wasn't spoken; if it was implied, say so and put it in open questions.

  Quote the note's author freely — their reasoning is the part worth preserving. Render every other
  participant in paraphrase: their words are their information too, and this file is committed.

  A call is often mostly about something other than the repo you're in. Say so in a scope note under
  the TL;DR and let the brief be as thin as the material warrants — inflating it is a failure, not
  thoroughness.
-->


# <YYYY-MM-DD> — <client or meeting name>

## TL;DR

<Two or three sentences. What this meeting changed.>

<!-- Scope note, when most of the call was about something else. Omit if the whole call was in scope. -->
**Scope note:** <what dominated the call, and that only the <this repo> portion is captured here.>

## Decisions made

<!-- Decided, not discussed. Include the reasoning — it's what makes the decision reviewable later. -->

- **<decision>** — <the reasoning behind it, and who made the call>

## Delta vs. the plan

### Already planned
<!-- Asked for, already tracked. Cite the issue or roadmap line. -->
- <ask> → #<n>

### New scope
<!-- Asked for, not tracked anywhere. These are the candidate issues below. -->
- <ask> — <why it's new>

### Changed scope
<!-- Something already planned moved. Say what it displaces; that's the part that costs money. -->
- <what moved> — <what it displaces or delays>

### Ruled out
- <what was declined or parked, and the reason>

## Commitments

| Who | What | By when |
| --- | --- | --- |
| <name> | <deliverable> | <date, or "unstated"> |

## Risks & open questions

- **<risk or question>** — <why it matters; who can resolve it>
- **Out of scope — <other project>** — <what came up about it, one line, and where it belongs.
  Never filed as an issue against this repo.>

## Candidate issues

<!--
  One block per issue to be drafted. This is the handoff into the issues step — everything here
  should be actionable as written, or it belongs in open questions instead.
-->

### <issue title>
- **Type / labels:** <type> · `needs-triage`
- **Why:** <the reason, in the client's terms>
- **Done looks like:** <acceptance check>

## ⚠ Sensitive — review before commit

<!--
  Anything that may not belong in a repo: rates, payment terms, personal details, third-party
  confidences, unflattering characterisations.

  Name the CATEGORY. Never reproduce the content in order to flag it — this file is committed, so a
  quote here is as public as a quote anywhere else in it. "Commercial terms were discussed and are
  excluded, see <where they went>" is the right shape. That keeps the omission a visible decision
  rather than a silent filter, which is the point, without the content landing in the repo.

  End with a line stating that nothing above is reproduced, only named, so a reader knows the
  omission was deliberate.
-->

- **<category>** — discussed and deliberately excluded; <where it lives instead>.
