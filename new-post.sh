#!/bin/bash

# Script to create a new blog post with proper formatting
# Usage: ./new-post.sh "Post Title" tag1,tag2,tag3

set -e

# Check if title is provided
if [ -z "$1" ]; then
    echo "Usage: ./new-post.sh \"Post Title\" [tags]"
    echo "Example: ./new-post.sh \"My New Post\" \"AI,philosophy,dialogue\""
    exit 1
fi

# Get current date in Jekyll format
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M:%S +0000')
DATETIME="$DATE $TIME"

# Convert title to filename-friendly format
TITLE="$1"
FILENAME=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
FILEPATH="_posts/${DATE}-${FILENAME}.md"

# Parse tags
TAGS="$2"
if [ -n "$TAGS" ]; then
    # Convert comma-separated tags to YAML array format
    TAG_ARRAY=$(echo "$TAGS" | sed 's/,/, /g' | sed 's/^/[/' | sed 's/$/]/')
else
    TAG_ARRAY="[]"
fi

# Create the post file
cat > "$FILEPATH" << EOF
---
layout: post
title: "$TITLE"
date: $DATETIME
tags: $TAG_ARRAY
author: Benjamin Tokgöz
# AI Transparency (uncomment and fill as needed)
# ai_dialogue_model: "Claude 3.5 Sonnet"
# ai_generation_model: "Claude 3.5 Sonnet" 
# ai_prompts:
#   - type: "Initial Dialogue Prompt"
#     model: "Claude 3.5 Sonnet"
#     content: |
#       Your prompt content here...
#   - type: "Blog Generation Prompt"
#     model: "Claude 3.5 Sonnet"
#     content: |
#       Your blog generation prompt here...
---

## Introduction

Write your introduction here...

## Main Content

Your main content goes here...

## Conclusion

Wrap up your thoughts...

---

*What are your thoughts on this topic? Feel free to engage with the ideas presented here.*
EOF

echo "Created new post: $FILEPATH"
echo "Opening in your default editor..."

# Try to open in common editors
if command -v code &> /dev/null; then
    code "$FILEPATH"
elif command -v vim &> /dev/null; then
    vim "$FILEPATH"
elif command -v nano &> /dev/null; then
    nano "$FILEPATH"
else
    echo "Please open $FILEPATH in your preferred editor."
fi
