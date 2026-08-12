# CLAUDE.md

Guidance for working in this repo. `debrief` is a **Claude Code skill pack** that turns Plaud voice
recordings — client meetings and solo brainstorms — into repo-aware briefs and conventional GitHub
issues. [`README.md`](README.md) covers what it does and [`ROADMAP.md`](ROADMAP.md) what's built;
this file is how to work on it.

## What this repo is — and isn't

It's markdown, not a program. The substance is `skills/*/SKILL.md` — versioned prompts with triggers
and scope — plus `templates/`, the artifacts those skills produce. There is no build step and no
runtime. "Testing" means running a skill against a real recording and reading what comes out, so
changes here are validated by use rather than by CI.

The deterministic half — fetching, indexing, issue wiring — may become a CLI later. Until then,
resist writing shell for work the agent already does natively. The value of this tool is judgment
about a transcript, and a script cannot hold that.

## Layout

- `skills/` — one directory per skill, each with a `SKILL.md`. Installed by symlink into
  `~/.claude/skills/`, so a `git pull` updates the tool on every machine.
  - `debrief-profile` — draft a repo's intake profile from its own docs
  - `debrief-intake` — recording to brief
  - `debrief-issues` — brief to wired issue drafts
- `templates/` — `PROFILE.md` (the per-repo context file) and the two brief skeletons. These get
  copied into target repos, so they must read as fill-in-the-blank, not as documentation *about*
  filling in blanks.
- `install.sh` — the symlink installer.

## Non-negotiables

If a change conflicts with these, the change is wrong.

1. **Explicit recordings only.** Never a batch sweep over an archive. A voice archive holds personal
   and legal material that has no business entering a project pipeline.
2. **Raw transcripts are never written into a repo.** Local scratch only; the brief is the artifact
   that lands.
3. **Issues are drafted, shown, then created on a human's word** — never as a side effect of
   producing a brief. Everything generated carries `needs-triage`.
4. **Repo-scoped.** The tool acts on the repo the user is standing in and never reaches across
   repos. In a repo that isn't Brett's, detect the local labels and apply nothing estate-specific.
5. **Sensitive content is surfaced, not silently filtered.** Flag it in the brief and let a human
   decide. Quietly dropping it hides a judgment call that should be visible.

## Skill conventions

- Frontmatter carries `name` (matching the directory) and a `description` written for *matching* —
  the phrases a user would actually say. That description is the entire retrieval mechanism, so it
  earns more care than the body.
- One skill, one job. `debrief-intake` produces a brief and stops; issue creation is a separate
  skill with its own gate, because the two carry different risk.
- Prefer the Plaud **MCP tools** over the CLI: they return structured data, while `plaud` prints
  formatted prose and has no JSON output.
- Fetch the polished transcript block where it exists — it is markedly cleaner input than raw.

## Workflow

`main` is protected: branch → PR → green AgentGate → **Brett merges**. Never self-merge. Commits are
SSH-signed, and agent-authored commit messages end with a `Co-Authored-By:` trailer naming the
model. See [`CONTRIBUTING.md`](CONTRIBUTING.md).
