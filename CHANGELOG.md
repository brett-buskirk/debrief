# Changelog

All notable changes to debrief are documented here. The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- README now documents **how to actually set the tool up and use it**: a per-machine install, a
  per-repo setup step that says what to ask for and which sections need hand-editing afterwards, and
  the three-step usage loop with its three approval gates. It previously said the profile was
  "generated, then edited by hand" without ever saying how to generate it.
- Sensitive content is **named by category, never quoted**. Reproducing a confidence in order to flag
  it commits it — the brief is a tracked file. Found by running the loop against a real client call.
- Third parties are **paraphrased, not quoted**. Their words are their information, and a private
  repo can be made public later.
- A brief may be **short**: a call is often mostly out of scope for the repo you're in, and the brief
  says so in a scope note rather than inflating the material.
- Briefs are **named for what's in scope**, not for the recording's title, which may itself be
  sensitive.
- `install.sh` and the README no longer claim a restart is needed — a running session picks the
  skills up immediately.

### Added
- `templates/PROFILE.md` — the per-repo intake profile, generalized from the Day One voice-note
  template, with a vocabulary table and a "where things go" section added.
- `templates/brief-meeting.md`, `templates/brief-brainstorm.md` — the two brief shapes.
- `skills/debrief-profile` — draft a repo's intake profile from its own docs, labels, and milestones.
- `skills/debrief-intake` — turn one named recording into a repo-aware brief, checked against the
  roadmap and open issues.
- `skills/debrief-issues` — draft fully-wired issues from a brief; created only on explicit approval.
- `install.sh` — symlink the skills into `~/.claude/skills/`.
- Initial scaffold.
