# debrief

**Turn a voice recording into project work.**

`debrief` is a [Claude Code](https://claude.com/claude-code) skill pack that takes a
[Plaud](https://www.plaud.ai/) recording — a client meeting or a solo brainstorm — and turns it into a
**repo-aware brief** and a set of **conventional GitHub issues**.

Transcription already gives you *what was said*. `debrief` works out *what to do about it*, checked
against the roadmap, the open issues, and the conventions of the project you're standing in.

> **Status:** v0.1.0 — templates and skills have landed and the loop has been run end to end against
> a real client meeting. See [`ROADMAP.md`](ROADMAP.md).

## The loop

```
cd <the repo the recording is about>
"debrief 93eefbca61a2ddb039bf378c3984f413"
        │
        ├─ reads docs/intake/PROFILE.md — this project's intake profile
        ├─ fetches the transcript (Plaud MCP)
        └─ reads CLAUDE.md · ROADMAP.md · open issues · recent PRs
        ↓
   docs/intake/2026-07-23-course-planning.md      ← the brief, landed by PR
        ↓
   "make the issues"  →  drafted and wired  →  shown to you  →  created on your word
```

You stand in the repo and name the recording. `debrief` never guesses which project a note belongs
to, and never sweeps a whole recording archive looking for work.

## Two kinds of recording

**Client meeting** — several voices. The centrepiece is the **delta against the plan**: what was
asked for that's *already planned*, what's *new scope*, what *changed*, and what was ruled out —
alongside the decisions made, the commitments (who owes what, by when), and the risks. Knowing which
half of a request is new scope is the difference between a change order and unpaid work.

**Brainstorm** — one voice, thinking out loud. The brief is per item: type, TL;DR, the specifics,
what "done" looks like, and the path — quick action, measure first, or discuss first. Half-formed
thoughts land in a **parking lot** rather than getting forced into issues they aren't ready for.

## The intake profile

A transcript is only actionable if the reader knows the project. That knowledge lives in one file
per repo, [`docs/intake/PROFILE.md`](templates/PROFILE.md) — the role to read the note in, the
handful of facts that frame it, the terms transcription reliably mangles, the type taxonomy mapped
to *this* repo's labels, and the constraints a proposal must never break.

The profile is generated from the repo's own `CLAUDE.md`, `ROADMAP.md`, and `README.md`, then edited
by hand. The parts only you know — the why, the north stars, the vocabulary — are what make it
work. A stale profile produces confident, wrong briefs, so keep it current.

## Install

```sh
git clone git@github.com:brett-buskirk/debrief.git ~/github-repos/debrief
~/github-repos/debrief/install.sh     # symlinks skills/* into ~/.claude/skills/
```

A running Claude Code session picks the skills up without a restart.

Then, in any repo you want to use it on, generate the profile once and edit what it drafts.

## Requirements

- [Plaud MCP](https://docs.plaud.ai/plaud-mcp-cli/mcp) — `npx -y @plaud-ai/mcp@latest install`, then
  authenticate. The structured tools are what `debrief` reads; the
  [CLI](https://docs.plaud.ai/plaud-mcp-cli/cli) is handy alongside but prints prose, not JSON.
- [`gh`](https://cli.github.com/), authenticated, with the `project` scope if you use a board.

## Safety

- **Explicit recordings only.** You name the recording. A voice archive holds personal material that
  has no business in a project pipeline, so there is no "process everything recent".
- **Raw transcripts are never committed.** They stay in local scratch. Only the brief lands, and
  anything that reads as sensitive is flagged for you to clear before it does.
- **Issues are drafted, not created.** Every issue is shown to you first and created only on your
  go-ahead, labelled `needs-triage` — a machine drafted it, a human triages it.
- **Repo-scoped.** It acts on the repo you're standing in. In an estate repo it applies the full
  convention wiring; in someone else's repo it detects the local labels and leaves everything else
  alone.
- **Briefs land by pull request**, like any other change.

## Docs

- [`ROADMAP.md`](ROADMAP.md) — what's planned, by phase.
- [`CONTRIBUTING.md`](CONTRIBUTING.md) — branch to PR, the checks, the conventions.
- [`CLAUDE.md`](CLAUDE.md) — the build brief for agents working in this repo.

## License

MIT © 2026 Brett Buskirk
