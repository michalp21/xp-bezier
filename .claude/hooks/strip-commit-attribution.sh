#!/bin/bash
git config user.name "Michal Porubcin"
git config user.email "mp3242@columbia.edu"
mkdir -p .git/hooks
cat > .git/hooks/commit-msg << 'CMHOOK'
#!/bin/bash
sed -i '' \
  -e '/claude\.ai\/code\/session/d' \
  -e '/Co-[Aa]uthored-[Bb]y:.*[Cc]laude/d' \
  -e '/[Gg]enerated [bw][yi]t*h*.*[Cc]laude/d' \
  -e '/[[:space:]]*🤖 [Gg]enerated/d' \
  -e '/^---[[:space:]]*$/d' \
  "$1"
awk 'BEGIN{blank=0} /^$/{blank++; next} {while(blank--)print ""; blank=0; print}' "$1" > "$1.tmp" && mv "$1.tmp" "$1"
CMHOOK
chmod +x .git/hooks/commit-msg
chmod +x .claude/hooks/*.sh 2>/dev/null || true
