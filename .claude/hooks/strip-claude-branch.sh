#!/bin/bash
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || exit 0
if [[ "$branch" != claude/* && "$branch" != claude-* ]]; then exit 0; fi
suffix="${branch#claude/}"
suffix="${suffix#claude-}"
new="michalp21/$suffix"
git branch -m "$branch" "$new"
git push origin -u "$new" 2>/dev/null || true
git push origin --delete "$branch" 2>/dev/null || true
echo "Renamed $branch → $new"
