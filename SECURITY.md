# Security

## Reporting

Open a [private security advisory](https://github.com/brett-buskirk/debrief/security/advisories/new),
or a normal issue if it isn't sensitive. Expect a reply within a few days.

## What this project is

`debrief` is a set of markdown prompts for Claude Code. There is no runtime, no build step, and no
server — it ships no executable code beyond `install.sh`, which only creates symlinks. So the
interesting risks aren't memory-safety bugs; they're about what ends up written down.

The design answers to three of them:

- **Raw transcripts never enter a repo.** They stay in local scratch; only the brief is committed.
- **Recordings are named explicitly, never swept.** A voice archive holds personal, legal, and family
  material that has no business in a project pipeline, so there is no "process everything recent."
- **Sensitive content is surfaced by category, never quoted.** Reproducing a confidence in order to
  flag it commits it, and a brief is a tracked file.

A bug that causes any of those to be violated — a transcript landing in a commit, an archive being
swept, sensitive content quoted into a brief — is a security issue here, not just a defect. Please
report it that way.

## Credentials

`debrief` reads Plaud through its MCP server and GitHub through `gh`; both hold their own
credentials, and this project neither stores nor transports them.
