---
name: nano-banana-pro
description: Generates high-quality images using Google Gemini flash and pro models for integration into designs. Use this skill for any image generation requests, including frontend components, graphics, hero images, and icons. Triggers on keywords like "generate an image", "nano banana", or specific visual creation requests.
---

# Nano Banana Pro - Gemini Image Generation

Generates custom images using Google's Gemini models for integration into frontend designs.

## Prerequisites

To use this skill, ensure the following dependencies are met:

1. **UV Package Manager**: This skill uses `uv` for script execution. [Install UV](https://github.com/astral-sh/uv).
2. **Gemini API Key**: Set the `GEMINI_API_KEY` environment variable with your Google AI API key. You can also create a `.env` file in the project root with `GEMINI_API_KEY=your_key_here` (ensure `.env` is in your `.gitignore`).

## Available Models

| Model | ID | Best For | Max Resolution |
|-------|-----|----------|----------------|
| **Flash** | `gemini-2.5-flash-image` | Speed, high-volume tasks | 1024px |
| **Pro** | `gemini-3-pro-image-preview` | Professional quality, complex scenes | Up to 4K |

## Image Generation Workflow

### Step 1: Generate the Image

Use the `scripts/image.py` script located within this skill's directory. You can run it using `uv`:

```bash
uv run skills/nano-banana-pro/scripts/image.py \
  --prompt "Your image description" \
  --output "assets/output.png"
```

**Note**: If you are unsure of the skill's absolute path, locate it first. By default, most agents can reference it via `skills/nano-banana-pro/scripts/image.py` from the project root.

Options:
- `--prompt` (required): Detailed description of the image to generate.
- `--output` (optional): Output file path. **Defaults to `assets/generated_<timestamp>.png`** in the project root if omitted.
- `--aspect` (optional): Aspect ratio - "square", "landscape", "portrait" (default: square).
- `--reference` (optional): Path to a reference image for style, composition, or content guidance.
- `--model` (optional): Model to use - "flash" (fast) or "pro" (high-quality) (default: flash).
- `--size` (optional): Image resolution for pro model - "1K", "2K", "4K" (default: 1K, ignored for flash).

### Using Different Models

**Flash model (default)** - Fast generation, good for iterations:
```bash
uv run skills/nano-banana-pro/scripts/image.py \
  --prompt "A minimalist logo design"
```

**Pro model** - Higher quality for final assets:
```bash
uv run skills/nano-banana-pro/scripts/image.py \
  --prompt "A detailed hero illustration for a tech landing page" \
  --model pro \
  --size 2K
```

### Using a Reference Image

To generate an image based on an existing reference:

```bash
uv run skills/nano-banana-pro/scripts/image.py \
  --prompt "Create a similar abstract pattern with warmer colors" \
  --reference "assets/reference.png"
```

The reference image helps Gemini understand the desired style, composition, or visual elements you want in the generated image.

### Step 2: Integrate with Frontend Design

After generating images, incorporate them into frontend code:

**HTML/CSS:**
```html
<img src="./generated-hero.png" alt="Description" class="hero-image" />
```

**React:**
```jsx
import heroImage from './assets/generated-hero.png';
<img src={heroImage} alt="Description" className="hero-image" />
```

**CSS Background:**
```css
.hero-section {
  background-image: url('./generated-hero.png');
  background-size: cover;
  background-position: center;
}
```

## Crafting Effective Prompts

Write detailed, specific prompts for best results:

**Good prompt:**
> A minimalist geometric pattern with overlapping translucent circles in coral, teal, and gold on a deep navy background, suitable for a modern fintech landing page hero section

**Avoid vague prompts:**
> A nice background image

### Prompt Elements to Include

1. **Subject**: What the image depicts
2. **Style**: Artistic style (minimalist, abstract, photorealistic, illustrated)
3. **Colors**: Specific color palette matching the design system
4. **Mood**: Atmosphere (professional, playful, elegant, bold)
5. **Context**: How it will be used (hero image, icon, texture, illustration)
6. **Technical**: Aspect ratio needs, transparency requirements

## Integration with Frontend-Design Skill

When used alongside the frontend-design skill:

1. **Plan the visual hierarchy** - Identify where generated images add value
2. **Match the aesthetic** - Ensure prompts align with the chosen design direction (brutalist, minimalist, maximalist, etc.)
3. **Generate images first** - Create visual assets before coding the frontend
4. **Reference in code** - Use relative paths to generated images in your HTML/CSS/React

### Example Workflow

1. User requests a landing page with custom hero imagery
2. Invoke nano-banana-pro to generate the hero image with a prompt matching the design aesthetic
3. Invoke frontend-design to build the page, referencing the generated image
4. Result: A cohesive design with custom AI-generated visuals

## Output Location

The script determines where to save images based on these rules:

1. **If `--output` is provided**: Saves to that exact path (relative to your current working directory).
2. **If `--output` is omitted**: Finds your project root by searching upward from your current directory for markers (`.git`, `package.json`, `devenv.nix`, `pyproject.toml`), then saves to `<project-root>/assets/generated_<timestamp>.png`.

The script works correctly from any directory within your project, including subdirectories. It will always find the project root and save to the correct location.

**Recommended filenames:**
- `hero-abstract-gradient.png` for hero images
- `icon-user-avatar.png` for icons
- `bg-pattern-geometric.png` for backgrounds
