---
recording_id: cad5361f40143a96f51185a02e6a321e
recorded: 2026-08-13
duration: 35s
mode: brainstorm
repo: brett-buskirk/debrief
issues: []   # filled in when issues are created
---

# 2026-08-13 — should a brief drop personal material, or flag it?

_A 35-second note holding one item, entirely in scope for this repo._

## Personal material: a third category between "relevant" and "sensitive"

**Type:** Safety rule
**TL;DR:** Asks whether `debrief` separates project material from personal chatter and ignores the
chatter. It partly does — but today that material lands under `⚠ Sensitive` rather than being
dropped, and the taxonomy has no bucket for "personal but not confidential."

### What I'm seeing / want

> "With the debrief app, does it take and pull apart the difference between relevant material and
> personal material, such as sharing what you did over the weekend, what you had for dinner, et
> cetera? The code needs to ignore that and only pull in the relevant parts to add to the workflow."

Answering the question directly: **partly, and deliberately differently from what's described.**

Three existing mechanisms already do some of this work:

- `debrief-intake` step 4 strips filler and false starts — but that's verbal noise, not topic
  relevance.
- Step 10 and the `CHANGELOG` establish that "a short brief is a correct brief": out-of-scope
  material gets a scope note instead of inflating the document.
- `PROFILE.md` → "Other projects in the same recording" routes off-topic *project* talk to open
  questions.

What none of them cover is **mundane personal conversation**. Under step 8, "personal or medical
detail" is classed as sensitive, so today a mention of dinner would be named as a category under
`⚠ Sensitive` in a tracked file. That is the wrong outcome for two reasons: it is noise, not a
confidence, and writing "personal detail — excluded" into git to describe someone's dinner gives
trivia a permanence it never warranted.

So the real shape of this item is not "add a filter." It is: **the taxonomy has two buckets where it
needs three.**

| Bucket | Example | Handling |
| --- | --- | --- |
| Relevant | project decisions, asks, risks | goes in the brief |
| **Personal noise — missing today** | weekend plans, dinner | dropped, exclusion visible but uncategorised |
| Sensitive | rates, medical, third-party confidences | named by category, never quoted |

### Specifics

- `skills/debrief-intake/SKILL.md` — step 4 (what gets stripped) and step 8 (what counts as
  sensitive). Step 8's "personal or medical detail" is the phrase doing the over-capturing.
- `CLAUDE.md` non-negotiable 5, and its restatement in `docs/intake/PROFILE.md`.
- `templates/brief-brainstorm.md` and `templates/brief-meeting.md` — the `⚠ Sensitive` block's
  guidance, if a third category needs a home.

### Desired outcome

A recording mixing project talk with personal chatter produces a brief where the chatter appears
neither in the body nor as an itemised entry under `⚠ Sensitive`, while genuinely sensitive material
is still named by category. Per this repo's bar, proven by running it against a real recording that
contains both — not by the markdown reading well.

### Constraints / north stars

- **Direct tension with non-negotiable 5** — "Sensitive content is surfaced, not silently filtered.
  Flag it in the brief and let a human decide. Quietly dropping it hides a judgment call that should
  be visible." Taken literally, dropping personal material is exactly what that forbids.

  The tension may be resolvable rather than real. Rule 5 exists to stop a *judgment call* being
  hidden — someone's dinner is not a judgment call. If so, the fix is to define the boundary between
  noise and sensitive precisely enough that rule 5 keeps its full force over the material it was
  written for, rather than to relax it. **That reading is a proposal, not a decision** — the rule is
  a non-negotiable and moving it is not this brief's call.
- **"The code needs to ignore that"** presumes a program. This repo is "markdown, not a program," and
  `CLAUDE.md` says to "resist writing shell for work the agent already does natively." The filter
  here is a prompt instruction in a `SKILL.md`, not a parser — a framing correction, not an
  objection to the ask.

### Path & open questions

**Discuss first** — it touches a non-negotiable, which the profile routes here regardless of how
straightforward the change looks.

- Where exactly does the boundary sit? Health, family, and legal material seem to stay sensitive
  while weekend and dinner become noise — but that line needs stating, not assuming.
- Should the drop be genuinely silent, or leave a trace? A single line such as "N minutes of
  non-project conversation excluded" would honour rule 5's spirit — the omission stays a visible
  decision — without giving trivia a category in git. **Not raised in the recording; offered as an
  option, not a conclusion.**
- Does this apply to the meeting delta as well, or only to brainstorms?

---

## Parking lot

- Whether this belongs at capture time rather than brief time. The v0.2.0 round-trip item generates
  the Plaud-side capture template from `PROFILE.md`; a capture prompt that separates project talk
  from everything else would mean less to filter downstream. **This connection was not made in the
  recording** — noted here because it may make the item cheaper, and parked rather than assumed.

## ⚠ Sensitive — review before commit

- **None.** The recording names "the weekend" and "dinner" as illustrations of a category to filter,
  not as personal disclosures. Nothing here required exclusion.
