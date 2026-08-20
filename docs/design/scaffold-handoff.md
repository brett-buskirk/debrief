# Scaffolding a repo from a brainstorm

_Design note. Settled 2026-08-20, from the brainstorm briefed in
[`2026-08-20-new-repo-from-brainstorm.md`](../intake/2026-08-20-new-repo-from-brainstorm.md).
No code has been written for this yet._

## The question

A brainstorm about a project that doesn't exist yet has nowhere to land. `debrief-intake` requires a
repo you're standing in, with a profile in it. So the note either gets briefed into an unrelated
repo — polluting that repo's ledger — or stays out of the tool and is lost.

Two shapes were considered for fixing it, and both were rejected.

## Rejected: let `debrief` create the repo

This inverts non-negotiable 4:

> **Repo-scoped.** The tool acts on the repo the user is standing in and never reaches across repos.
> In a repo that isn't Brett's, detect the local labels and apply nothing estate-specific.

"Never reaches across repos" is what makes `debrief` safe to point at a client repo. A version that
creates repositories holds write access to an entire account rather than to one directory. The rule
can't be read narrowly here the way it could for the personal-noise question — the ask is literally
to act somewhere other than where you are standing.

## Rejected: `huginn new --plaud <id>`

Putting the voice half into the scaffolder instead. Rejected for the mirror image of the reason the
first option was rejected: **`debrief` shouldn't hard-wire one person's conventions, and `huginn`
shouldn't hard-wire one vendor's voice service.** Both are public tools; each dependency narrows the
audience of the tool that gains it.

The implementation details make it worse, not better:

- **`huginn` is 541 lines of bash whose entire dependency list is `git`, `jq`, and `gh`.** `cmd_new`
  is about 100 lines and completely deterministic — write files, `git init`, `gh repo create`, apply
  ruleset and labels. Being predictable is the whole reason it is trustworthy for scaffolding.
- **A repo name, a description, and initial README content are judgment**, and bash cannot hold
  judgment. That leaves three options, all bad: shell out to an LLM (adding Claude Code and an API
  key to a `git`/`jq`/`gh` tool, and making a deterministic scaffolder non-deterministic); write the
  raw transcript into the new repo (a direct violation of non-negotiable 2, which exists because
  voice archives hold personal and legal material); or pipe transcript prose into `--desc` and get a
  rambling paragraph as the repository description.
- **The `plaud` CLI has no JSON output** — only `--output`, `--block`, `--polished`, `--highlights` —
  so a shell implementation would be parsing prose regardless.

## The design: point the dependency the other way

**`debrief` calls the scaffolder.** The tool that has judgment orchestrates the tool that doesn't.

`debrief` already depends on Plaud and on a model's reading of a transcript; both are intrinsic to
what it is. `huginn` depends on neither and is better for it. So the scaffolder stays a dumb,
predictable executor and `debrief` supplies the parts that need thought.

Two pieces, in order of how much they cost:

1. **A hand-off (cheap, and doesn't touch any rule).** When a brainstorm is about a project that
   doesn't exist, `debrief-intake` says so and prints the command to run, rather than running it.
   A suggestion is not an action, so no gate moves and non-negotiable 4 stands untouched.

2. **A configured `scaffold_command` (still small).** The profile names the command to invoke, with
   the derived name and description passed in. The estate-specific part then lives in *config*, which
   is exactly what non-negotiable 4 asks for — "apply nothing estate-specific" is about behaviour, not
   about what a user may configure for themselves.

   ```
   scaffold_command: huginn new {name} --desc "{desc}" --private
   ```

   Someone else's value is `gh repo create {name} --private`, or a `cookiecutter` invocation. Creating
   a repository must sit behind the same explicit approval that filing issues does.

## What `huginn` is asked to change: nothing

Its existing interface already accepts everything a model would produce, and `--dry-run` supplies the
preview the approval gate needs:

```sh
huginn new <name> --desc "…" --private --dry-run
```

It also already has the "defaults, customizable" behaviour that was nearly rebuilt from scratch:
`cmd_new` resolves each template through `first_of "$REPO_CONVENTIONS/…" "$HERE/templates/…"`,
preferring the user's `repo-conventions/` and falling back to bundled defaults. That is
defaults-plus-override, already shipped.

## Still open

- **Where does the brief land?** The brief describes the repo it lives in, but that repo does not
  exist when the recording is read. First commit of the new repo, or a normal PR afterwards?
- **How does the profile get written?** `debrief-profile` works by reading a repo's own docs and
  labels. A freshly scaffolded repo has almost nothing to read, so the profile would have to be
  derived from the brainstorm itself. **This is the most interesting part of the whole idea** — it is
  the one piece no scaffolder can do and no existing tool does — and it was not in the original note.
- **Where is the command run from?** Every precondition today assumes a git repo with a profile. A
  brand-new project has neither.

## Provenance

Recording `626195339971708a2b29f00d3d0589b8`, 2026-08-20. The `huginn` findings come from reading
that repository at `a5fd410`; nothing in it was modified, and no change is being requested of it.
