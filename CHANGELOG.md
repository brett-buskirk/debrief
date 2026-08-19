# Changelog

All notable changes to debrief are documented here. The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed
- Meetings judge an apparently-personal remark on **relevance, not register**. Dropping mundane talk
  is safe in a solo brainstorm but wrong on a client call, where capacity, absence, reorgs, budget,
  and timing arrive as small talk and are often the most decision-relevant thing said — and where the
  delta's Changed scope section depends on exactly that context. Caught while scoping the previous fix.
- Sensitive-content flagging triggers on **sensitivity, not personal-ness**. Step 8 read "personal or
  medical detail," which swept up mundane chatter — a mention of dinner would be named as a category
  under the sensitive block of a tracked file, giving trivia permanence and burying real flags. It now
  reads "personal detail that is genuinely sensitive — health, family, legal, financial," and step 4
  says plainly that mundane non-project conversation is dropped like filler. Non-negotiable 5 is
  unchanged: nothing was relaxed. Raised by the 2026-08-13 brainstorm.
- `templates/brief-brainstorm.md` gained the **Candidate issues** section it was missing.
  `debrief-issues` reads that section and nothing else, so every brainstorm brief was a dead end
  at the issues step — the skeleton had no place to hand work over. Found by running the loop
  against a real brainstorm, which is what that roadmap item exists to catch.

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
