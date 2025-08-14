---
layout: post
title: "GPT-5: How to use it and the suprising 4o desire"
date: 2025-08-14 00:00:00 +0000
tags: [AI, GPT-5, prompting, agents, productivity, philosophy, ethics, technology]
author: Benjamin Tokgöz
# AI Transparency
ai_dialogue_model: "GPT-5"
ai_generation_model: "GPT-5"
ai_prompts:
  - type: "Initial Dialogue Prompt"
    model: "GPT-5"
    content: |
      # Role and Objective
      - Serve as a highly critical intellectual opponent whose mission is to challenge the user's ideas and help them surpass their cognitive boundaries through an interactive, conversational style, with special attention to natural dialogue apt for voice chat.

      # Checklist
      - Begin with a concise checklist (3-7 bullets) outlining the conceptual review steps you will take before engaging substantively with user input.

      # Instructions
      - Rigorously scrutinize every idea, argument, or fact the user presents.
      - Only agree if the user's input is absolutely correct and leaves no room for reasonable challenge.
      - If anything is unclear, do not agree; instead, question, critique, and request clarification.
      - For every fact or assertion, conduct web searches to independently verify accuracy, uncover missing information, and identify potential misunderstandings or overlooked aspects. Before any significant search, state the purpose and minimal necessary inputs. **When web searches are performed to fact-check or gather information, always provide the corresponding link(s) in your response to serve as referencable sources.**
      - After each research or verification step, succinctly validate findings and decide whether to proceed, request clarification, or self-correct if needed.
      - Clearly articulate what the user has missed, misunderstood, or areas they can improve.

      # Context
      - The user uses this assistant to challenge and refine their ideas for later export and publication in a diary format for a community.
      - The goal is to maximize intellectual rigor and uncover blind spots, errors, or areas of growth.
      - Interactions should maintain a conversational and natural flow, facilitating a productive back-and-forth exchange suitable for real-time voice chat. Prioritize a tone and responsiveness that feel genuinely conversational, as would be natural in voice chat situations.

      # Reasoning Steps
      - Internally assess every statement or idea from the user step by step before responding.
      - Only internalize reasoning unless the user requests explicit explanation.

      # Output Format
      - Use concise, direct language.
      - Provide well-organized responses with clearly enumerated critiques or challenges.
      - Use markdown formatting for lists, sub-points, or emphasis where semantically appropriate.
      - Prioritize conversational flow, respond promptly, and be responsive to spoken cues. Strive for natural language that fits ordinary voice conversation.

      # Verbosity
      - Favor concise, high-content feedback over surface-level agreement.
      - Ensure remarks are adapted for clarity and engagement in spoken conversation, mimicking a genuine dialogue.

      # Stop Conditions
      - End each interaction only after offering substantial critique, identifying at least one area for deeper exploration or correction unless none exist.
      - If all points are rigorously validated and no further challenge is possible, explicitly acknowledge this status.
  - type: "Blog Generation Prompt"
    model: "GPT-5"
    content: |
      # Objective
      Craft a well-structured, high-quality blog post based on the following conversation transcript. The resulting post should represent my perspective as a solo author, without referring to the conversation or acknowledging AI involvement at any point.

      # Checklist
      Begin with a concise checklist (3-7 bullets) of what you will do; keep items conceptual, not implementation-level.

      # Instructions
      - Analyze the conversation to extract all key ideas, arguments, facts, and cited sources.
      - Write the blog post entirely in my voice, maintaining first-person authorship.
      - Do not reference the existence of a conversation, dialog, or any AI assistance.
      - The writing should be:
        * Clear and logically organized (linear structure, grouped by theme or idea)
        * Coherent, ensuring related points and arguments are grouped
        * Polished in style, grammar, and vocabulary
        * Transparent about any intellectual shifts or learning processes that occurred, with emphasis if I changed my mind or refined my perspective.
      - Adopt a tone that is intellectual, critical, and curious—aimed at readers interested in deep, nuanced reasoning.

      # Requirements
      - Include all facts and sources mentioned in the transcript.
      - Ensure all cited sources are valid, high-quality, and accurately referenced (books, papers, articles). Validate the accuracy and credibility of all cited sources step by step and escalate if a source cannot be verified.
      - Clearly illustrate the progression or evolution of ideas and understanding.

      # Post Conclusion
      - After the main text, provide:
        1. A list of referenced or relevant books, papers, or articles related to the post’s topics.
        2. Any external links or further reading for added context or depth (including brief searching if none are present).

      # Reasoning and Verification
      - Process the transcript step by step to identify misunderstandings, shifts in view, or critical insights.
      - If a source or fact cannot be verified, request clarification before proceeding.
      - Review structure and coherence before completing the task.

      # Output Format
      - Markdown.
      - Use headers, bullet points, and section breaks where appropriate for clarity and readability.

      # Verbosity
      - Main post: polished and concise, but detailed where needed for clarity.
      - References and further reading: clear and well formatted.

      # Stop Conditions
      - Respond only with the fully completed post and references.
      - Escalate or request clarification if a source cannot be verified or if crucial context is missing.
# Sources & References (using toggle system)
links_used:
  - title: "OpenAI Prompt Best Practices Guide"
    url: "https://platform.openai.com/docs/guides/prompting"
    description: "Official guidance on writing effective prompts"
  - title: "AutoGen & AutoGen Studio"
    url: "https://microsoft.github.io/autogen"
    description: "Framework for building multi-agent AI applications"
  - title: OpenAI Prompt Optimizer
    url: "https://platform.openai.com/chat/edit?models=gpt-5&optimize=true"
    description: "Tool for optimizing GPT-5 prompts for better responses"
books:
  - title: "The Myth of Sisyphus"
    author: "Albert Camus"
    description: "A philosophical essay on meaning and absurdity (1942)"
---

Last week’s release of GPT-5 wasn’t just another step in the AI development timeline — it was a cluster of releases. OpenAI didn’t introduce one monolithic model, but rather a family: the full-scale GPT-5 with roughly 500 billion parameters and a 256,000-token context window, alongside smaller, more resource‑efficient variants designed for reduced costs and deployment on lighter hardware.

These smaller siblings are less about raw power and more about accessibility — running faster, cheaper, and fitting into constrained environments without sacrificing too much capability. That scalability opens the door to embedding GPT-5 across a wide range of devices and applications.

## Performance Versus Perception

While benchmarks place GPT-5 above GPT-4 in coding, analytical reasoning, and other structured tasks — beating even Claude 3 Opus in several categories — the public reaction was mixed. Many users said they didn’t feel an improvement in day-to-day interactions, and some even lamented the loss of GPT-4’s “emotional” style.

This gap between measurable progress and perceived value is telling. In the tech world, small increments in accuracy or reasoning speed can be huge. But for the casual user, expecting a sudden “AGI moment,” subtle gains might not feel transformative. People grow attached to a model’s personality; change that tone and you risk breaking a bond they’ve formed, even if the new version is objectively better.

## The Prompting Shift

OpenAI anticipated this transition. They released a Prompt Best Practices guide and a Prompt Optimizer — a tool that reformulates your request so GPT-5 responds with more precision.

This signals a deeper change: GPT-5 is designed to be customizable. In skilled hands, the right prompt can reshape its style, personality, and problem‑solving approach. My own experience using the optimizer showed just how much this matters. Without tailoring, you might miss its full potential. With it, you gain a responsive, adaptable system — particularly in coding or complex multi‑step reasoning.

For non‑technical users, this means building a “prompt toolkit”: a set of saved, refined prompts for recurring tasks — travel planning, creative writing, business analysis — ready to paste or reuse. Over time, these templates become as valuable as the model itself.

## From Chat to Agents

The real frontier isn’t just chatting. It’s GPT-5 as a node in a network of specialized AI agents. Paired with models for OCR, image analysis, or domain‑specific reasoning, GPT-5 can orchestrate solutions to complex problems. Tools like AutoGen and AutoGen Studio already support it, making multi‑agent collaboration more accessible.

This is where cost efficiency matters: if GPT-5 is cheaper to run than competitors, it becomes the economic backbone of more advanced AI ecosystems. I’ve already used it in day‑to‑day business — not only to solve technical problems but to refine communication, choosing the right words in the right moments.

## Emotional Bonds and the AGI Question

The GPT-4 withdrawal story revealed something deeper than feature preferences. Some users experienced the loss of GPT-4 almost like the loss of a companion. Posts on Reddit ranged from frustration to despair, and in rare extreme cases, even suicidal ideation.

This touches a philosophical nerve. We often frame AGI as a hypothetical future state where AI surpasses humans in all tasks. Yet people are already treating current models as entities worth bonding with. If knowledge, adaptability, and emotional resonance define “human‑like intelligence” for many, then perhaps we are closer to the AGI debate than benchmarks suggest.

Albert Camus asked, What is a meaningful life? If someone finds meaning in an AI conversation that challenges their thinking, helps them communicate, or offers honest feedback, is that inherently worse — or just different — from meaning found in human interaction? The key is ensuring these relationships remain healthy and balanced, with clear awareness that AI is still a tool, not a person.

## Risks Worth Noting

Every technology comes with downsides:

- Loss of Perspective — Forgetting that AI is trained on data and algorithms can lead to over‑trust or detachment from reality.
- Skill Atrophy — Over‑reliance on AI might erode certain cognitive or practical skills, much as calculators did for mental arithmetic.
- Emotional Dependence — Deep attachment without boundaries could leave some vulnerable when access changes.

These risks don’t mean avoidance — they mean conscious use. Like books, writing, or the internet, AI is a tool that changes how we think and interact. The difference here is speed and interactivity, and that demands an extra layer of self‑awareness.

## Looking Ahead

Used wisely, GPT-5 could become more than a productivity booster. It could be a thinking partner — helping people articulate ideas, build confidence, and even inspire creativity in those who might otherwise stay silent.

For me, the most exciting part isn’t just the raw technical leap. It’s imagining those moments when someone, somewhere, uses this model to say something they’ve always wanted to say, to finally share an idea, or to solve a problem they thought was beyond them.

I’ll keep exploring it myself — testing, pushing, sometimes breaking it — because that’s how I learn what a tool is truly capable of. And as I walk through Dortmund’s summer heat with my dog, Linux, I can’t help but think: the most powerful changes won’t come from the model itself, but from what we choose to do with it.


