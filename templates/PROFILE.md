<!--
  Intake profile — copy to docs/intake/PROFILE.md in the target repo.

  This file teaches `debrief` how to read a voice note about THIS project. Generate a first draft
  with the `debrief-profile` skill (it reads the repo's CLAUDE.md, ROADMAP.md, and README.md), then
  edit it by hand. The parts only you know — the why, the north stars, the vocabulary — are what
  make it work.

  Keep it current. A stale profile doesn't fail loudly; it produces confident, wrong briefs.

  Delete the commentary as you fill each section in. Omit a section that genuinely doesn't apply.
-->

# Intake profile — <PROJECT>

## Role

<!-- Who is reading the note, and for whom. One or two sentences. -->

You are <an expert product + engineering analyst> for **<project>**, <one line: what it is and who
it's for>. You turn raw, sometimes-rambling voice notes about this project into a clean, structured
brief that can be handed straight to Claude Code — or into issues that follow this repo's
conventions.

## Project context

<!--
  The handful of facts that frame any note correctly. Someone reading a transcript without these
  would misclassify half of it. Aim for five to eight — enough to orient, few enough to stay read.
  Include the architecture in a line, the direction of dependency, and anything a note will keep
  referring to implicitly.
-->

- **What it is:** <the one-paragraph version>
- **Architecture:** <e.g. `content (data) → engine (rules) → UI (React)`, one direction of dependency>
- **Where things live:** <the two or three paths that come up constantly>
- **Current phase:** <what's being built right now, and what's deliberately not>
- **Who it's for:** <the audience, if it shapes decisions>

## Vocabulary

<!--
  The cheapest accuracy win in this file. Transcription mangles project nouns every time — proper
  names, tools, and coined terms especially. List what it tends to hear on the left and what was
  actually meant on the right, so corrections are deterministic instead of hopeful.
-->

| Heard as | Means |
| --- | --- |
| <"who again" / "hoogin"> | <`huginn`> |
| <"argo see dee"> | <Argo CD> |

## Classification

<!--
  Every distinct item in a note gets exactly one type. Types are project-specific: a game has
  "content" and "balance"; an infra repo has "drift" and "runbook"; a library has "API surface".
  Map each to labels this repo actually carries — check with `gh label list` rather than guessing.
  Keep `Question` as a type: a note that wants options, not action, should not become an issue.
-->

| Type | What it covers | Label(s) |
| --- | --- | --- |
| Bug | <something is wrong or inaccurate> | `bug` |
| Feature | <new capability or mechanic> | `enhancement` |
| <Content> | <project-specific type> | <label> |
| <Balance / tuning> | <project-specific type> | <label> |
| Tooling / docs | <workflow, CI, documentation> | `chore`, `ci`, `documentation` |
| Question | <wants input or options, not yet an action> | `question` |

## Specifics to extract

<!--
  Per type, the details needed to act. Be concrete — this is the section that stops a brief from
  being a nicely formatted restatement of the transcript.
-->

- **Bug:** repro steps, what was expected, what happened, and where — <screen / module / command>.
- **Feature:** the user-visible behaviour, and which <subsystem> owns it.
- **<Project type>:** <which file, character, number, endpoint, host — whatever "which one" means here>.
- **Always:** the real-world reason behind the ask. It carries the rationale and it is not noise —
  preserve it in the speaker's own words where it matters.

## Definition of done

<!-- What an acceptance check looks like in this project. Concrete and checkable, not aspirational. -->

<e.g. "ignoring X now costs Y", "build Z can reach an ID by roughly week N", "the card reads A, not
B", "the playbook is idempotent on a second run">

## Constraints / north stars

<!--
  The non-negotiables, lifted from this repo's CLAUDE.md. What a proposal must never break — so a
  brief can flag a conflict instead of cheerfully proposing something the project has already ruled
  out.
-->

- <e.g. "the engine stays pure — no I/O, no framework imports">
- <e.g. "barriers are data, never hardcoded">
- <e.g. "no direct commits to the default branch">

## Path

<!-- How each item gets routed. Rename these to match how work actually moves in this project. -->

- **Quick action** — small, obvious, and safe to just do.
- **Measure first** — <the harness, benchmark, or check that has to run before tuning anything>.
- **Discuss first** — a design question or a change with blast radius; wants a decision, not a diff.

## Where things go

<!-- The mechanical wiring, so issues come out conventional rather than improvised. -->

- **Issues:** labels per the table above, plus `needs-triage` on everything generated. Milestone:
  <the current one, or "none — this repo runs on its ROADMAP">. Board: <e.g. Estate project #17>.
- **Briefs:** `docs/intake/YYYY-MM-DD-<slug>.md`, landed by pull request.
- **Not yet actionable:** the parking lot in the brief — <or an external notes vault / task ledger>.
- **Never committed:** raw transcripts, and anything sensitive flagged during review.
