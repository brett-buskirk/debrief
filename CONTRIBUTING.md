# Contributing

`debrief` is markdown, not a program. There is no build step and no runtime — the substance is
`skills/*/SKILL.md`, versioned prompts with triggers and scope, plus the `templates/` they produce.
That shapes how changes get made and how they get verified.

## How a change is verified

**There is no CI over the part that matters.** AgentGate and GitGuardian check the diff; nothing
checks whether a skill still reads a transcript well. So a change to a skill or a template is done
when it has been **run against a real recording and the output read** — not when the markdown reads
well. Say in the PR which recording exercised it, or say plainly that the change is reasoned rather
than observed. Both are acceptable; conflating them is not.

Every fix in v0.1.0 after the initial scaffold came from watching a real run fail. That is the
intended loop.

## Workflow

- **No direct commits to `main`.** Branch → PR → green checks → merge. This is enforced by a
  repository ruleset, not convention.
- **Commits must be signed.** The ruleset requires it; SSH signing is fine.
- **Checks that must pass:** AgentGate (`secrets` and `dangerous_patterns` block; scope warns) and
  GitGuardian.
- **Agent-authored commits** end with a `Co-Authored-By:` trailer naming the model that wrote them.
- **One focused change per PR**, small enough to read in full.

### Contributing from a fork

Fork pull requests get the same AgentGate check that branch PRs get. Two things follow from how that
is wired, and both will otherwise look like bugs:

- **The guardrail config is read from `main`, not from your branch.** A PR that edits `.agentgate.yml`
  or the workflow itself will not see those edits applied to its own run — they take effect after
  merge. That is deliberate: a pull request should not be able to relax the check that is judging it.
- **Config changes belong in their own PR.** Don't bundle a guardrail change into a feature change.

## Things that are not style preferences

These are the project's non-negotiables, listed in full in [`CLAUDE.md`](CLAUDE.md). A change that
breaks one is wrong regardless of how well it reads:

- **Explicit recordings only** — never a sweep over an archive.
- **Raw transcripts never enter a repo** — local scratch only; the brief is what lands.
- **Issues are drafted, shown, then created on a human's word**, always carrying `needs-triage`.
- **Repo-scoped** — the tool acts on the repo you are standing in and never reaches across repos.
- **Sensitive content is surfaced, not silently filtered.**

Never commit secrets; `.env` files and keys are gitignored.

## A note on scripts

The deterministic half — fetching, indexing, issue wiring — may become a CLI one day; it is on the
roadmap under "Later." Until then, resist writing shell for work the agent already does natively.
The value here is judgment about a transcript, and a script cannot hold that.
