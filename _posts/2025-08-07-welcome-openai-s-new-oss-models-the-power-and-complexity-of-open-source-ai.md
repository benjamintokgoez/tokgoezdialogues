---
layout: post
title: "Welcome OpenAI's new oss Models! The Power and Complexity of Open-Source AI"
date: 2025-08-06 00:00:00 +0000
tags: [AI, open-source, philosophy, security, governance, technology]
author: Benjamin Tokgöz
# AI Transparency
ai_dialogue_model: "GPT-4o"
ai_generation_model: "GPT-4o" 
ai_prompts:
  - type: "Initial Dialogue Prompt"
    model: "GPT-4o"
    content: |
      I want you to act as my intellectual opponent. Your goal is to push me beyond my cognitive limits. Do not agree with me if anything is unclear—challenge all of my ideas. Only agree when I am absolutely correct. If I present a fact, perform web searches to verify its accuracy and identify any missing information or misunderstandings. Then, tell me what I've overlooked. Your mission is to help me reach—and surpass—my cognitive boundaries.

      I will use you as a tool to challenge and discuss ideas. Afterwards I will Export it for a kind of a diary format and publish ideas of the day to the community
  - type: "Blog Generation Prompt"
    model: "GPT-4o"
    content: |
      I want you to write a well-structured, high-quality blog post based on the following conversation I'll paste below. The conversation is between myself and an AI, where I explored, challenged, and refined ideas. The AI supported me in critically questioning assumptions, introducing relevant sources, and offering counterpoints that helped deepen my thinking.
      The final blog post should be written entirely from my point of view, as if I'm the sole author. Do not mention that this came from a conversation or was generated with AI assistance.
      My discussion style is often nonlinear—I mix topics or return to earlier ideas—but I want this blog post to be:
      * Clear and logically structured
      * Coherent, grouping related ideas together
      * Polished, in terms of style and language
      * Transparent, showing intellectual evolution if it occurred
      Specifically, you must:
      ✅ Include all facts and sources mentioned in the discussion. ✅ Ensure all sources are valid, high-quality, and accurately cited. ✅ If I had a misunderstanding or changed my view during the conversation, highlight that learning process clearly in the post. ✅ Maintain a tone that is intellectual, critical, and curious—aimed at readers who value deep, reasoned reflection.
      At the end of the post, include:
      * A list of books, papers, or articles that are either referenced or relevant to the post's topic(s).
      * Any external links or further reading that offer additional depth or context. If you don't have them, search in the web!
# Sources & References (using toggle system)
links_used:
  - title: "Introducing gpt-oss - OpenAI (August 5, 2025)"
    url: "https://openai.com/index/introducing-gpt-oss/"
    description: "Official announcement of OpenAI's gpt-oss-120b and gpt-oss-20b open-weight language models"
  - title: "gpt-oss-120b & gpt-oss-20b Model Card - OpenAI (August 5, 2025)"
    url: "https://openai.com/index/gpt-oss-model-card/"
    description: "Technical specifications and safety evaluation details for the gpt-oss models"
  - title: "The XZ Utils Backdoor Incident (2024) – Ars Technica"
    url: "https://arstechnica.com/security/2024/04/what-we-know-about-the-xz-utils-backdoor-that-almost-infected-the-world/"
    description: "Full breakdown of the supply chain attack on critical Linux infrastructure"
  - title: "Ollama: Local LLM Deployment Tool"
    url: "https://ollama.ai/"
    description: "Tool for running large language models locally"
  - title: "Arch Linux Installation Guide"
    url: "https://wiki.archlinux.org/title/Installation_guide"
    description: "Comprehensive guide for Arch Linux installation"

books:
  - title: "The Wealth of Networks"
    author: "Yochai Benkler"
    description: "Seminal work on peer production, governance, and open-source ecosystems"
  - title: "Liars and Outliers"
    author: "Bruce Schneier"
    description: "On trust, security, and how societies deal with systemic risk"
  - title: "Good Faith Collaboration"
    author: "Joseph Reagle"
    description: "A study of how Wikipedia and other open-source communities function"
---

Today I read something that caught my attention and immediately triggered a cascade of thoughts: OpenAI released two open-source models — one with 20 billion parameters and another with 120 billion — a move they haven't made in years. After a long period of proprietary development, seeing OpenAI return to open-source territory is not just a strategic shift; it's symbolic.

And for someone like me, who grew up on Linux, has worked in open-source environments since childhood, and now finds himself at Microsoft working with Azure and Linux deployments, this is more than an announcement — it's a call for reflection.

## Why This Matters

Releasing not only the models but also their weights, technical specs, and reference code to the public is a powerful gesture. This means anyone — individuals, startups, research groups — can download, experiment with, fine-tune, and deploy these models on-premises. That's a game-changer for countries and sectors with high data privacy demands, like Germany's government or healthcare institutions.

The use cases are broad:

- Air-gapped deployments
- Custom fine-tuning on private datasets
- Increased control over data pipelines

But with freedom comes risk — and complexity.

## The Risks Behind Open Weights

The moment models become publicly available in full — especially their weights — we enter unpredictable territory. Modified versions could:

- Lose essential safety guardrails like content filters
- Be distributed under the same name as the original models
- Include malicious changes or backdoors

This is not theoretical. Just think of the XZ Utils compromise, where a small but essential Linux tool was quietly manipulated. If it took experts time to notice a vulnerability in such a tool, imagine how difficult it is to detect subtle manipulations in billion-parameter models.

So while transparency is powerful, interpretability remains elusive. Even with full access to weights and code, understanding how a model reaches its conclusions is still a black box — even to the experts.

## Open Source: Romanticism vs. Realism

I love open source. My dog is named Linux. I've used Linux since I was 12. I was drawn to computer science because of the collaborative spirit of open-source communities. And even today, it inspires me — especially when I see giants like Microsoft and Google contributing to projects like Kubernetes.

But we need to move beyond romanticizing open source.

In today's world, open source is critical infrastructure. And yet, some projects are still maintained by anonymous volunteers. We, as a society, depend on software that may be governed by unclear or even fragile structures.

Think of that contrast: In democracies, we create systems with checks, balances, and institutions. Yet in open source, the power dynamics can be anarchic — sometimes empowering, sometimes dangerous.

## Do We Need a New Social Contract for Open Source?

Maybe we're at a historical moment where open source is no longer just a technical concern. It's not just about developers anymore. It affects national security, critical healthcare systems, and education.

So we should be asking:

- Should governments regulate or certify critical open-source projects?
- Should there be standardized governance structures for projects like Kubernetes?
- Can we balance freedom of innovation with public safety?

These are not easy questions. And I don't claim to have the answers. But we need to start asking them — openly, publicly, and with people beyond tech circles.

## A Word of Caution (and Optimism)

We need to stay cautious when downloading fine-tuned models from the internet. If you find a model that claims to be "smarter" or tailored to "bring the perspective of China" or "offer superhuman performance" — be skeptical. Especially if the source is unofficial.

Even if there's no malicious intent, such models can carry invisible biases, security flaws, or unexpected behaviors.

That said — open-source innovation is still a beautiful thing. Community-driven models might be less polished, but they often reflect diverse perspectives and unlock use cases proprietary models would never allow. We should embrace them, but with the tools and mindset of responsibility, critical thinking, and safety.

## My Immediate Plan

This evening, I'm going to deploy the smaller of the two new open-source models on my local machine using Ollama. I don't have the compute power for the 120B version, but running the 20B locally is enough to test capabilities.

Why?

Because there's always the scenario — not just theoretical — that centralized access to LLMs could disappear. Imagine if companies like OpenAI stopped public access to their APIs. What happens then?

Having a local model means independence. You're not tied to an internet connection or a corporate API key. It's a tool that stays with you. That's powerful.

And yes, I might even reinstall Arch Linux on my Mac Studio just for this purpose. Why not?

## Summing It Up

We shouldn't forget what the foundational values of open source are:

- Transparency
- Security
- Resilience
- Governance

And while open source will always be a part of who I am, I don't want to be idealistic about it. We need to stay critical. We need to rethink governance. And we need to protect what's great about open source without blindly trusting it.

Because when done right, open source is not just powerful — it's essential.

---

*What are your thoughts on the balance between open-source innovation and security? Have you experimented with local AI model deployment? Feel free to engage with the ideas presented here.*
