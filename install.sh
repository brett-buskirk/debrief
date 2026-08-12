#!/usr/bin/env bash
# install.sh — link the debrief skills into Claude Code's user skills directory.
#
# Skills are symlinked, not copied, so `git pull` in this repo updates the tool everywhere at once.
# Re-running is safe: existing debrief symlinks are re-pointed, and anything that is not a symlink
# is left strictly alone (never clobber a real directory someone put there by hand).
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

mkdir -p "$DEST"
printf '\n  debrief · linking skills into %s\n\n' "$DEST"

linked=0 skipped=0
for skill in "$HERE"/skills/*/; do
  [ -d "$skill" ] || continue
  skill="${skill%/}"
  name="$(basename "$skill")"
  target="$DEST/$name"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    printf '  ! %-18s exists and is not a symlink — left alone\n' "$name" >&2
    skipped=$((skipped + 1))
    continue
  fi

  ln -sfn "$skill" "$target"
  printf '  ✓ %-18s → %s\n' "$name" "$skill"
  linked=$((linked + 1))
done

printf '\n  %d linked, %d skipped. A running session picks them up without a restart.\n\n' "$linked" "$skipped"
