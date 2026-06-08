#!/usr/bin/env bash
#
# Tokgöz Dialogues — scaffold a new post.
# Usage: ./new-post.sh "Post Title" "tag1,tag2,tag3"
#
set -euo pipefail

if [ -z "${1:-}" ]; then
  echo "Usage: ./new-post.sh \"Post Title\" [tags]"
  echo "Example: ./new-post.sh \"Walking and thinking\" \"AI,philosophy\""
  exit 1
fi

TITLE="$1"
DATE="$(date '+%Y-%m-%d')"
DATETIME="$DATE $(date '+%H:%M:%S %z')"
SLUG="$(printf '%s' "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g; s/--*/-/g; s/^-//; s/-$//')"
FILE="_posts/${DATE}-${SLUG}.md"

if [ -n "${2:-}" ]; then
  TAGS="[$(printf '%s' "$2" | sed 's/ *, */, /g')]"
else
  TAGS="[]"
fi

if [ -e "$FILE" ]; then echo "Refusing to overwrite existing $FILE"; exit 1; fi

cat > "$FILE" <<EOF
---
layout: post
title: "$TITLE"
date: $DATETIME
tags: $TAGS
author: Benjamin Tokgöz
published: false   # flip to true (or remove) when ready
# AI transparency — shown in the manifest and the prompt.txt tab
ai_dialogue_model: "GPT-5"
ai_generation_model: "GPT-5"
ai_prompts:
  - type: "Initial Dialogue Prompt"
    model: "GPT-5"
    content: |
      Serve as a highly critical intellectual opponent. Challenge every idea,
      argument, and fact I present. Only agree when I am absolutely correct;
      otherwise question, critique, and verify with web searches (cite links).
      Keep it conversational — natural for voice chat on a walk.
  - type: "Blog Generation Prompt"
    model: "GPT-5"
    content: |
      Turn the following conversation transcript into a polished blog post in my
      voice as the sole author. Do not mention the conversation or any AI. Keep
      all facts and sources, show where my view evolved, and end with references.
# Sources — shown in the collapsible sources block
links_used: []
books: []
---

Write the finished post here, in Markdown.

<!-- Optional: to publish the raw walk transcript too, add a line with
     <!-- TRANSCRIPT --> and put the conversation below it. -->
EOF

echo "Created $FILE"
