---
recording_id: <plaud file id>
recorded: <YYYY-MM-DD>
duration: <e.g. 13m54s>
mode: brainstorm
repo: <owner/repo>
issues: []   # filled in when issues are created
---

<!--
  Brainstorm brief — the shape `debrief` produces for a single-voice recording.

  One block per distinct item, most important first; a ten-minute ramble often holds four unrelated
  thoughts. Strip filler, make implicit assumptions explicit, and correct mis-transcribed project
  terms using the profile's vocabulary table — but do not invent specifics that aren't there. Where
  a gap matters, it goes in open questions rather than getting filled in with something plausible.

  Preserve the reasoning in the speaker's own words where it carries the "why". That's the part
  worth keeping; the rest is scaffolding.

  Anything half-formed goes to the parking lot. Forcing it into an issue creates a ticket nobody can
  act on and quietly loses the actual thought.
-->

# <YYYY-MM-DD> — <what this session was about>

## <item title>

**Type:** <Bug | Feature | Tooling/Docs | Question | project-specific type>
**TL;DR:** <one or two sentences>

### What I'm seeing / want

<The cleaned-up point, with the reasoning preserved.>

### Specifics

- <which file / module / screen / number / command>
- <repro steps, if it's a bug>

### Desired outcome

<What "done" looks like — an acceptance check where one is possible.>

### Constraints / north stars

<What this must respect, or what it must not break. Flag it here if the idea conflicts with one.>

### Path & open questions

<quick action | measure first | discuss first> — <questions that need an answer before this moves>

---

## Parking lot

<!--
  Thoughts that aren't ready: too vague to act on, blocked on a decision, or interesting but out of
  scope for now. Kept verbatim enough to be recognisable later. These do not become issues.
-->

- <the thought, and what it's waiting on>

## Candidate issues

<!--
  The handoff into `debrief-issues`, which reads this section and nothing else. One block per issue
  to be drafted, and everything here has to be actionable exactly as written.

  An item reaches this section only once its path is settled. Anything still marked "discuss first"
  or "measure first" stays where it is, and parking-lot items never come here. That routing is the
  gate; pulling an unresolved thought forward is what defeats it.

  Empty is a normal outcome for a brainstorm — a note that raised one hard question should produce
  no issues at all. Write the "None" line rather than deleting the heading, so the skill finds an
  explicit answer instead of a missing section.
-->

_None — <why: every item is still discuss-first, or parked>._

### <issue title>
- **Type / labels:** <type> · `needs-triage`
- **Why:** <the reason, in your own words from the note>
- **Done looks like:** <acceptance check>

## ⚠ Sensitive — review before commit

<!--
  Usually empty for a solo note — but a solo note wanders, and a project repo is not the place for
  where it wandered to. Name the category and leave the content out; never reproduce something in
  order to flag it.
-->

- **<category>** — discussed and deliberately excluded; <where it lives instead>.
