# flake

Run this inside an existing repo to copy in everything from this template without overwriting existing files, while appending this repo's `.gitignore` and skipping this `README.md`:

```bash
tmp="$(mktemp -d)" && (git clone -q --depth 1 https://github.com/fjolne/flake.git "$tmp" && rsync -a --ignore-existing --exclude '.git' --exclude '/README.md' --exclude '/.gitignore' "$tmp"/ ./ && { [ -f "$tmp/.gitignore" ] && { [ -s .gitignore ] && printf '\n' >> .gitignore; cat "$tmp/.gitignore" >> .gitignore; }; }; rc=$?; rm -rf "$tmp"; exit $rc)
```
