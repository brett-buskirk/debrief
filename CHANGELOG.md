# Changelog

All notable changes to debrief are documented here. The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
