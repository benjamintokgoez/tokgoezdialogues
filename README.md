# Tokgöz Dialogues

A terminal-styled Jekyll blog at **[tokgoezdialogues.com](https://tokgoezdialogues.com)**.

The concept: I think out loud on walks with my dog **Linux**, use a conversational
AI as a *critical opponent* to challenge those thoughts, then run the conversation
through a second prompt that shapes it into a post — and I publish the receipts.
Every entry ships its finished **output**, the exact **prompts** I used, and the
**sources** behind it, as switchable terminal "files".

- **Stack:** Jekyll 4, vanilla CSS/JS (zero front-end dependencies)
- **Theme:** hand-rolled Linux-terminal UI, Tokyo Night palette, light/dark toggle
- **Deploy:** GitHub Actions → GitHub Pages (custom domain via `CNAME`)

## Writing a post

Create `_posts/YYYY-MM-DD-slug.md` (or run `./new-post.sh "Title" "tag1,tag2"`).
The body is the finished post; everything else lives in front matter:

```markdown
---
layout: post
title: "Your title"
date: 2025-08-14 00:00:00 +0000
tags: [AI, philosophy]
author: Benjamin Tokgöz
# AI transparency — rendered into the manifest + the prompt.txt tab
ai_dialogue_model: "GPT-5"
ai_generation_model: "GPT-5"
ai_prompts:
  - type: "Initial Dialogue Prompt"
    model: "GPT-5"
    content: |
      The exact prompt you used, verbatim…
  - type: "Blog Generation Prompt"
    model: "GPT-5"
    content: |
      The prompt that turned the conversation into this post…
# Sources — rendered into a collapsible "sources.md" block
links_used:
  - title: "Some source"
    url: "https://example.com"
    description: "why it matters"
books:
  - title: "A Book"
    author: "Author"
    description: "relevance"
---

The finished post goes here, in Markdown.
```

Notes:
- `ai_prompts` populates the **prompt.txt** tab; `ai_dialogue_model` / `ai_generation_model`
  populate the provenance **manifest**. All are optional — a post with none renders as a plain article.
- Want to publish a raw walk transcript too? Add a `<!-- TRANSCRIPT -->` marker in the body;
  everything after it becomes a **walk.log** tab.
- `published: false` keeps a post as a draft (it won't appear).

## Local development

Jekyll 4 needs **Ruby ≥ 3.1**. On most Linux distros, install Ruby + bundler via
your package manager (or `rbenv` / `mise`), then:

```bash
bundle install
bundle exec jekyll serve --livereload
# → http://localhost:4000/
```

(No system Ruby ≥ 3.1 handy? You can build in a container:
`docker run --rm -v "$PWD":/site -w /site ruby:3.3 bash -lc 'bundle install && bundle exec jekyll serve -H 0.0.0.0'`.)

## Deploying

Pushing to `main` triggers `.github/workflows/jekyll.yml`, which builds with Jekyll 4
and deploys to Pages. The custom domain is set by the `CNAME` file
(`tokgoezdialogues.com`); make sure the repo's **Settings → Pages → Source** is
**GitHub Actions**.

## The command palette (it's a small shell)

Press **`Ctrl`+`K`** or **`/`** anywhere. Type `help` for the full list. Commands:

| command | does |
|---------|------|
| `help`  | list all commands |
| `ls`    | list all entries (home) |
| `about` | the about page |
| `theme` | toggle dark / light |
| `feed`  | the Atom feed |
| `random`| open a random entry |
| `clear` | clear active tag filters |
| `top`   | scroll to top |
| `source`| view the repo on GitHub |

You can also just type to fuzzy-search every entry by title or tag. On a post,
`←` / `→` switch between the output / prompt / walk tabs.

## Project structure

```
_config.yml              site config (title, domain, social)
CNAME                    custom domain
_layouts/                default · home · post · page
_includes/               head · header · footer · palette · sources
_posts/                  entries (YYYY-MM-DD-slug.md)
assets/css/terminal.css  the design system
assets/js/main.js        theme · tag filter · tabs · ⟨ctrl-k⟩ palette
index.html               home
about.md                 about / method
search.json              palette search index (generated)
404.html                 terminal 404
new-post.sh              scaffold a new post
```
