# AI Transparency Feature

The Tokgoez Dialogues blog now includes a comprehensive AI transparency feature that allows authors to disclose the AI models and prompts used in content creation.

## How It Works

When you create a post with AI involvement, you can add special fields to the front matter that will automatically display an "AI Transparency" section on the post page.

## Front Matter Fields

Add these fields to your post's YAML front matter:

```yaml
# AI Transparency fields
ai_dialogue_model: "Claude 3.5 Sonnet"
ai_generation_model: "Claude 3.5 Sonnet" 
ai_prompts:
  - type: "Initial Dialogue Prompt"
    model: "Claude 3.5 Sonnet"
    content: |
      Your prompt content here...
      Multiple lines are supported.
  - type: "Blog Generation Prompt"
    model: "GPT-4"
    content: |
      Another prompt used in the process...
```

### Field Descriptions

- **`ai_dialogue_model`**: The AI model used for the original conversation/dialogue
- **`ai_generation_model`**: The AI model used to generate or structure the blog post (if different from dialogue model)
- **`ai_prompts`**: An array of prompts used during the creation process

### Prompt Object Structure

Each prompt in the `ai_prompts` array can have:
- **`type`** (optional): Description of the prompt's purpose (e.g., "Initial Dialogue", "Revision Request")
- **`model`** (optional): The specific model used for this prompt (if different from the main models)
- **`content`**: The actual prompt text (supports multi-line content with `|`)

## Visual Display

When AI transparency fields are present, the post will display:

1. **AI Transparency Header**: Clear section with robot emoji and title
2. **Model Information**: Shows which models were used for dialogue and generation
3. **Expandable Prompts**: Button to reveal/hide the actual prompts used
4. **Clean Styling**: Matches the overall blog design with terminal-inspired aesthetics

## Examples

### Simple Disclosure
```yaml
ai_dialogue_model: "Claude 3.5 Sonnet"
```

### Full Transparency
```yaml
ai_dialogue_model: "Claude 3.5 Sonnet"
ai_generation_model: "GPT-4"
ai_prompts:
  - type: "Philosophical Discussion"
    model: "Claude 3.5 Sonnet"
    content: |
      Let's explore the nature of consciousness in AI systems.
      What are the key philosophical questions we should consider?
  - type: "Blog Structure"
    model: "GPT-4"
    content: |
      Based on our dialogue, create a structured blog post that:
      - Introduces the topic clearly
      - Presents multiple viewpoints
      - Concludes with open questions
```

## Creating Posts with AI Transparency

The blog's post creation scripts now include commented templates for AI transparency:

```bash
# Create new post with transparency template
./manage-posts.sh create "My AI Dialogue" "AI,philosophy"
./new-post.sh "Another Post" "tags"
```

Both scripts will include commented AI transparency fields that you can uncomment and fill in as needed.

## Design Philosophy

This feature embodies the blog's commitment to:

- **Radical Transparency**: Being honest about AI collaboration
- **Educational Value**: Helping readers understand AI-human creative processes  
- **Reader Agency**: Letting readers decide how much detail they want to see
- **Future-Proofing**: Supporting various AI models and use cases

## Technical Implementation

- **Jekyll Integration**: Uses Liquid templating for conditional display
- **Responsive Design**: Works well on mobile and desktop
- **Accessibility**: Proper ARIA labels and keyboard navigation
- **Performance**: JavaScript only loads when needed

The prompts are hidden by default and revealed with a smooth animation when the user clicks the toggle button.

## Why This Matters

As AI becomes more prevalent in content creation, transparency isn't just ethical—it's educational. By showing the prompts and models used, we help readers:

1. Understand the collaborative nature of AI-assisted writing
2. Evaluate content with appropriate context
3. Learn about effective AI interaction techniques
4. Make informed decisions about engaging with the content

This feature sets a standard for responsible AI disclosure in blogging and content creation.
