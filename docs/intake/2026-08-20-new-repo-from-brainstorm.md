---
recording_id: 626195339971708a2b29f00d3d0589b8
recorded: 2026-08-20
duration: 1m00s
mode: brainstorm
repo: brett-buskirk/debrief
issues: []   # filled in when issues are created
---

# 2026-08-20 — spinning up a new repo from a brainstorm

_A one-minute note holding a single item, entirely in scope for this repo._

## Creating a new project repo from a brainstorm, instead of briefing an existing one

**Type:** Safety rule
**TL;DR:** Asks whether a brainstorm about a **brand-new** project could scaffold a private repo via
`huginn new` rather than brief the repo you're standing in. Genuinely useful, and it inverts
non-negotiable 4 — so it needs a decision before it needs a design.

### What I'm seeing / want

> "Instead of using the tool in the repo that I am standing in, what if I want to build a new
> repository or project based off of a brainstorming session? If so, this should use the `huginn new`
> tooling to scaffold the new repository to my particular conventions and standards. […] adding a
> brainstorming session about a brand new project should spin up a private repository based on my
> conventions and standards."

The pull is obvious: today a brainstorm about something that doesn't exist yet has nowhere to land.
You either brief it into an unrelated repo, which pollutes that repo's ledger, or you keep it out of
the tool entirely and lose it. Neither is right, and `huginn new` already solves the scaffolding half.

But the framing — *instead of* the repo you're standing in — is the exact inversion of the rule the
tool is built on:

> **"Repo-scoped.** The tool acts on the repo the user is standing in and never reaches across repos.
> In a repo that isn't Brett's, detect the local labels and apply nothing estate-specific."

That rule is load-bearing in two different ways here, and they pull in opposite directions:

1. **Blast radius.** "Never reaches across repos" is what makes it safe to point this at a client
   repo. A version that creates repositories is a tool with write access to the whole account, not to
   one directory. Repo creation isn't destructive, but it is outward-facing and awkward to undo.
2. **Estate coupling — and this is new since the recording.** The same rule says to "apply nothing
   estate-specific" outside Brett's repos. `huginn` is estate tooling. **`debrief` went public on
   2026-08-20**, the same day as this note, and is being shared with an outside community — so a
   feature that hard-depends on `huginn new` is one nobody who installs it from that post can use.

### Specifics

- `skills/debrief-intake/SKILL.md` — the scope section ("The current repo only") and preconditions 1–2,
  which assume a repo that already exists and already has a profile.
- `CLAUDE.md` non-negotiable 4, and its restatement in `docs/intake/PROFILE.md`.
- `huginn new <name>` is the existing scaffolder; invoking existing tooling doesn't run against the
  "resist writing shell" rule the way writing a new scaffolder would.
- Not on the roadmap in any phase, and no open issue — this is new scope.

### Desired outcome

Per this repo's bar, whatever is built is done when it has been **run against a real recording**: a
brainstorm about a project that does not exist produces a scaffolded repo and a brief that lands in
it, with the same explicit approval before anything is created that `debrief-issues` requires today.

### Constraints / north stars

- **Inverts non-negotiable 4** (quoted above). This is not a case where the rule can be read
  narrowly, as it was for the personal-noise question in #8 — the ask is literally to act somewhere
  other than the repo you're standing in. It needs amending or an explicit carve-out, and that is
  not a brief's call.
- **`debrief` is now public.** Anything estate-specific has to be optional, or it breaks the tool for
  everyone outside this account. A pluggable "scaffold command" with `huginn new` as *Brett's*
  configured value keeps both the feature and the rule; hard-wiring `huginn` does not. **This is an
  inference, not something the recording said** — the note predates the repo going public by hours.
- **Creating a repo must sit behind the same gate as filing issues** — drafted, shown, created on an
  explicit word. The three-gate design is the reason this tool is trustworthy.

### Path & open questions

**Discuss first.** The profile routes anything touching a non-negotiable here, and this one inverts
rather than clarifies. There is a design worth having, but not before the rule question is settled.

- Does this become a **fourth skill** (`debrief-scaffold`?) rather than a change to `debrief-intake`?
  A separate skill would keep intake's scope rule intact and put the repo-creating power behind its
  own gate — which is how `debrief-issues` was split off for exactly this reason.
- **Where does the brief land?** There is a chicken-and-egg: the brief is written into the repo it
  describes, but that repo doesn't exist yet. First commit of the new repo, or written after the
  scaffold and landed by PR like any other brief?
- **Where is it run from?** Every precondition today assumes you are inside a git repo with a profile.
  A brand-new project has neither.
- **How does the profile get written** for a repo with no docs to read? `debrief-profile` works by
  reading a repo's own `CLAUDE.md`, `README.md`, and labels. A freshly scaffolded repo has almost
  nothing to read, so the profile would have to come from the brainstorm itself — which is a more
  interesting idea than the scaffolding, and unaddressed in the note.

### Resolved — 2026-08-20

Settled without amending non-negotiable 4, and without asking anything of `huginn`. Full reasoning in
[`docs/design/scaffold-handoff.md`](../design/scaffold-handoff.md).

`debrief` will not create repositories, and `huginn` will not learn about Plaud. Instead the
dependency points the other way: `debrief` derives a name and description from the brainstorm and
hands off to a **configured** `scaffold_command`, so the estate-specific part lives in config rather
than in behaviour. `huginn new <name> --desc "…" --private --dry-run` already accepts exactly that,
so the design requires zero changes to it.

The `huginn new --plaud <id>` option raised after this brief was written was rejected for the mirror
of the reason `debrief` was not given repo-creating powers: a public scaffolder should no more
hard-wire one vendor's voice service than a public voice tool should hard-wire one person's
conventions. The three open questions above stand, and the profile-from-brainstorm one is now the
most valuable part of the idea.

---

## Parking lot

- Nothing parked. The note is single-topic and specific; its unresolved parts are decisions, not
  half-formed thoughts, so they are in open questions above.

## Candidate issues

_None._ The single item is **discuss first** and inverts a non-negotiable. Filing an issue would
presuppose the answer to a question this brief exists to raise.

## ⚠ Sensitive — review before commit

- **None.** The recording is a one-minute technical note about tooling.
