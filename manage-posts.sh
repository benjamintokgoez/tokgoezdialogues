#!/bin/bash
#
# Tokgöz Dialogues - Post Management Script
# 
# @author Benjamin Tokgöz <https://github.com/benjamintokgoez>
# @created 2025-08-07
# @updated 2025-08-07
# @description Enhanced script to manage blog posts (create, delete, list)
# @license MIT
#
# Enhanced script to manage blog posts
# Usage: 
#   ./manage-posts.sh create "Post Title" [tags]
#   ./manage-posts.sh delete [pattern]
#   ./manage-posts.sh list

set -e

POSTS_DIR="_posts"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to show usage
show_usage() {
    echo "Blog Post Management Script"
    echo ""
    echo "Usage:"
    echo "  $0 create \"Post Title\" [tags]     - Create a new post"
    echo "  $0 delete [pattern]                - Delete posts (interactive)"
    echo "  $0 list                            - List all posts"
    echo ""
    echo "Examples:"
    echo "  $0 create \"My New Post\" \"AI,philosophy,dialogue\""
    echo "  $0 delete \"vim\"                   - Delete posts with 'vim' in filename"
    echo "  $0 delete                          - Interactive delete (choose from list)"
    echo "  $0 list"
}

# Function to create a new post
create_post() {
    local title="$1"
    local tags="$2"
    
    if [ -z "$title" ]; then
        echo -e "${RED}Error: Post title is required${NC}"
        show_usage
        exit 1
    fi

    # Get current date in Jekyll format
    local date=$(date '+%Y-%m-%d')
    local time=$(date '+%H:%M:%S +0000')
    local datetime="$date $time"

    # Convert title to filename-friendly format
    local filename=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
    local filepath="$POSTS_DIR/${date}-${filename}.md"

    # Parse tags
    local tag_array="[]"
    if [ -n "$tags" ]; then
        # Convert comma-separated tags to YAML array format
        tag_array=$(echo "$tags" | sed 's/,/, /g' | sed 's/^/[/' | sed 's/$/]/')
    fi

    # Create the post file
    cat > "$filepath" << EOF
---
layout: post
title: "$title"
date: $datetime
tags: $tag_array
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

    echo -e "${GREEN}Created new post: $filepath${NC}"
    
    # Try to open in editor
    if command -v code &> /dev/null; then
        code "$filepath"
    elif command -v vim &> /dev/null; then
        vim "$filepath"
    elif command -v nano &> /dev/null; then
        nano "$filepath"
    else
        echo "Please open $filepath in your preferred editor."
    fi
}

# Function to list all posts
list_posts() {
    echo -e "${BLUE}Current posts:${NC}"
    echo ""
    
    if [ ! -d "$POSTS_DIR" ] || [ -z "$(ls -A $POSTS_DIR 2>/dev/null)" ]; then
        echo -e "${YELLOW}No posts found in $POSTS_DIR${NC}"
        return
    fi
    
    local count=1
    for post in "$POSTS_DIR"/*.md; do
        if [ -f "$post" ]; then
            local basename=$(basename "$post")
            local title=$(grep "^title:" "$post" | sed 's/title: *["'"'"']//' | sed 's/["'"'"']$//')
            local date=$(grep "^date:" "$post" | sed 's/date: *//')
            
            echo -e "${count}. ${GREEN}$basename${NC}"
            echo -e "   Title: $title"
            echo -e "   Date: $date"
            echo ""
            ((count++))
        fi
    done
}

# Function to delete posts
delete_posts() {
    local pattern="$1"
    
    if [ ! -d "$POSTS_DIR" ] || [ -z "$(ls -A $POSTS_DIR 2>/dev/null)" ]; then
        echo -e "${YELLOW}No posts found in $POSTS_DIR${NC}"
        return
    fi
    
    # If pattern provided, filter posts
    if [ -n "$pattern" ]; then
        local matching_posts=($(find "$POSTS_DIR" -name "*$pattern*.md" 2>/dev/null))
        
        if [ ${#matching_posts[@]} -eq 0 ]; then
            echo -e "${YELLOW}No posts found matching pattern: $pattern${NC}"
            return
        fi
        
        echo -e "${BLUE}Posts matching '$pattern':${NC}"
        for i in "${!matching_posts[@]}"; do
            local post="${matching_posts[$i]}"
            local basename=$(basename "$post")
            local title=$(grep "^title:" "$post" | sed 's/title: *["'"'"']//' | sed 's/["'"'"']$//')
            echo -e "$((i+1)). ${GREEN}$basename${NC} - $title"
        done
        
        echo ""
        read -p "Enter numbers to delete (space-separated, or 'all' for all): " selection
        
        if [ "$selection" = "all" ]; then
            for post in "${matching_posts[@]}"; do
                rm "$post"
                echo -e "${RED}Deleted: $(basename "$post")${NC}"
            done
        else
            for num in $selection; do
                if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le ${#matching_posts[@]} ]; then
                    local post="${matching_posts[$((num-1))]}"
                    rm "$post"
                    echo -e "${RED}Deleted: $(basename "$post")${NC}"
                fi
            done
        fi
    else
        # Interactive mode - show all posts
        echo -e "${BLUE}All posts:${NC}"
        local all_posts=($(find "$POSTS_DIR" -name "*.md" 2>/dev/null | sort))
        
        for i in "${!all_posts[@]}"; do
            local post="${all_posts[$i]}"
            local basename=$(basename "$post")
            local title=$(grep "^title:" "$post" | sed 's/title: *["'"'"']//' | sed 's/["'"'"']$//')
            echo -e "$((i+1)). ${GREEN}$basename${NC} - $title"
        done
        
        echo ""
        read -p "Enter numbers to delete (space-separated): " selection
        
        for num in $selection; do
            if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le ${#all_posts[@]} ]; then
                local post="${all_posts[$((num-1))]}"
                read -p "Really delete $(basename "$post")? (y/N): " confirm
                if [[ "$confirm" =~ ^[Yy]$ ]]; then
                    rm "$post"
                    echo -e "${RED}Deleted: $(basename "$post")${NC}"
                fi
            fi
        done
    fi
}

# Main script logic
case "$1" in
    "create")
        create_post "$2" "$3"
        ;;
    "delete")
        delete_posts "$2"
        ;;
    "list")
        list_posts
        ;;
    *)
        show_usage
        exit 1
        ;;
esac
