# debrief

**Turn a voice recording into project work.**

`debrief` is a [Claude Code](https://claude.com/claude-code) skill pack that takes a
[Plaud](https://www.plaud.ai/) recording — a client meeting or a solo brainstorm — and turns it into a
**repo-aware brief** and a set of **conventional GitHub issues**.

Transcription already gives you *what was said*. `debrief` works out *what to do about it*, checked
against the roadmap, the open issues, and the conventions of the project you're standing in.

> **Status:** v0.1.0 — templates and skills have landed, and the full loop (brief → issues) has
> been run end to end against both a real client meeting and a real brainstorm. See
> [`ROADMAP.md`](ROADMAP.md).

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

## Install

Once per machine.

```sh
git clone git@github.com:brett-buskirk/debrief.git ~/github-repos/debrief
~/github-repos/debrief/install.sh     # symlinks skills/* into ~/.claude/skills/
```

A running Claude Code session picks the skills up without a restart.

## Set up a repo

Once per repo you want to use it on.

A transcript is only actionable if the reader knows the project, and that knowledge lives in one
file: `docs/intake/PROFILE.md`. **You don't write it by hand and you don't copy the template.** Open
a Claude Code session in the repo and ask:

```
cd ~/github-repos/<repo>
```

> set up debrief here

That runs `debrief-profile`, which reads the repo's own `CLAUDE.md`, `README.md`, `ROADMAP.md`,
labels, and milestones, fills in [`templates/PROFILE.md`](templates/PROFILE.md), and opens a PR
adding `docs/intake/PROFILE.md`.

**Then edit what it drafted before merging.** It leaves a literal `<TODO: …>` wherever the repo's
docs didn't answer a question, and three sections carry knowledge that isn't written down anywhere
in the repo:

- **Vocabulary** — the project nouns transcription reliably mangles. The cheapest accuracy win in
  the file, and it should grow every time a brief gets a term wrong.
- **Constraints / north stars** — what a proposal must never break, so a brief can flag a conflict
  instead of cheerfully proposing something you've already ruled out.
- **Definition of done** — what a concrete acceptance check looks like in this project.

A stale profile doesn't fail loudly; it produces confident, wrong briefs. Keep it current.

## Use it

Three steps and three separate approvals — nothing compounds from a single "looks good."

**1. Brief a recording.** Stand in the repo it's about and name it:

> debrief cad5361f40143a96f51185a02e6a321e

`debrief-intake` fetches the polished transcript, picks **meeting** or **brainstorm** from the
speaker count, loads the profile alongside your roadmap and open issues, writes the brief to
`docs/intake/YYYY-MM-DD-<slug>.md`, and opens a PR. It creates no issues.

**2. Review the brief PR.** Two things want your eye: the `⚠ Sensitive` section, and anything left
as an open question. Merge when it reads true.

**3. File the issues** — the gated step:

> make the issues

`debrief-issues` reads only the brief's **Candidate issues** section, checks your existing issues for
near-duplicates, then prints a dry-run table with each full issue body and **stops**. Nothing is
created until you give a go-ahead for that specific set; approval never carries between runs.

The phrasings above aren't magic words — each skill matches on its `description`, so anything close
works ("create the intake profile", "turn this recording into a brief", "file these"). Naming the
skill directly works too.

### Finding a recording ID

```sh
plaud recent --days 30          # the last month
plaud search "weekly sync"      # by name keyword
plaud today
```

Or just ask in the session: *what recordings do I have from last week?*

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
