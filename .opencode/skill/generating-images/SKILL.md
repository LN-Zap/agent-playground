---
name: generating-images
description: >-
  Generate, edit, and batch-process images using Google Gemini AI (Nano
  Bananas). Supports text-to-image generation, image editing (style transfer,
  content modification), batch variations, multiple aspect ratios (1:1 through
  21:9), high-resolution output (1K-4K), and Google Search grounding for factual
  accuracy. Use this skill for: (1) Generating custom images from text
  descriptions, (2) Editing or modifying existing images, (3) Creating multiple
  image variations for exploration, (4) Ensuring factual accuracy with real
  landmarks, products, or people via search grounding.
---
# Nano Banana Pro

Generate, edit, and batch-process images using Google's Gemini AI. Choose between fast Flash model (1024px) or professional Pro model (up to 4K).

## Prerequisites

- **UV Package Manager**: Required for script execution. [Install UV](https://github.com/astral-sh/uv)
- **Gemini API Key**: Set `GEMINI_API_KEY` environment variable or create `.env` in project root with `GEMINI_API_KEY=your_key_here`

## Script Location

All script paths in this skill (e.g., `scripts/image.py`) are **relative to this SKILL.md file's directory**. When executing commands, construct absolute paths by combining the skill folder with the relative path.

For example, if you loaded this skill from `/workspace/someproj/.github/skills/generating-images/SKILL.md`, then:
- `scripts/image.py` → `/workspace/someproj/.github/skills/generating-images/scripts/image.py`
- `scripts/batch_generate.py` → `/workspace/someproj/.github/skills/generating-images/scripts/batch_generate.py`

## Quick Start

### Generate an image
```bash
uv run ./scripts/image.py \
  --prompt "A minimalist logo design"
```

### Edit an existing image
```bash
uv run ./scripts/image.py \
  --prompt "Make the background blue" \
  --reference "photo.jpg"
```

### Generate 20 variations
```bash
uv run ./scripts/batch_generate.py \
  "Pixel art robot" -n 20 -d ./assets/robots -p robot
```

### Generate with search grounding (real-world accuracy)
```bash
uv run ./scripts/image.py \
  --prompt "The Eiffel Tower at sunset" \
  --search
```

For more examples, see [references/examples.md](references/examples.md).

## Core Workflows

### Single Image Generation (`image.py`)

Generate new images or edit existing ones.

**Options:**
- `--prompt` (required): Image description or editing instructions
- `--output` (optional): Output file path. Defaults to `assets/generated_<timestamp>.png` in project root
- `--aspect` (optional): Aspect ratio—`square`, `landscape`, `portrait`, or specific ratios like `1:1`, `16:9`, `21:9` (default: square)
- `--reference` (optional): Path to input image for editing/style transfer
- `--model` (optional): `flash` (fast, 1024px) or `pro` (high-quality, up to 4K) (default: flash)
- `--size` (optional): Resolution for pro model—`1K`, `2K`, `4K` (default: 1K, ignored for flash)
- `--search`: Enable Google Search grounding for factual accuracy with real landmarks, products, people

**When to use:**
- Generate new images from descriptions
- Edit or modify existing images (style transfer, content changes)
- Create high-resolution assets (pro model + 4K)
- Ensure accuracy with real-world subjects (--search flag)

**Auto-resolution for editing:** When editing with pro model, resolution auto-detects based on input image size (1K: <1500px, 2K: 1500-3000px, 4K: >3000px).

### Batch Generation (`batch_generate.py`)

Generate multiple image variations efficiently with progress tracking and optional parallel execution.

**Options:**
- `--count`, `-n`: Number of images to generate (default: 10)
- `--dir`, `-d`: Output directory (default: ./generated-images)
- `--prefix`, `-p`: Filename prefix (default: image)
- `--aspect`: Aspect ratio (default: square)
- `--model`: Model to use (default: flash)
- `--size`: Resolution for pro model (default: 1K)
- `--search`: Enable Google Search grounding
- `--delay`: Seconds between generations (default: 3.0, ignored if --parallel > 1)
- `--parallel`: Concurrent requests, 1-5 (default: 1)
- `--quiet`, `-q`: Suppress progress output

**When to use:**
- Explore multiple design variations
- Generate icon sets, pattern collections
- Speed up generation with parallel execution (--parallel 3 or higher)
- Create consistent batches with auto-naming

**Rate limiting:** Default 3-second delay between requests prevents quota hits. Reduce with `--delay` or use `--parallel` for concurrent requests (increases speed but uses quota faster).

## Image Editing Features

Edit existing images with natural language instructions.

**Style transfer:** "Convert to watercolor painting" or "Apply noir aesthetic"

**Content modification:** "Add a rainbow in the sky" or "Replace background with forest"

**Appearance changes:** "Make colors vibrant" or "Increase contrast with dramatic lighting"

**Composition:** "Zoom in on subject" or "Reposition to rule of thirds"

## Google Search Grounding

Enable `--search` flag for factually accurate images involving:
- Real people (celebrities, historical figures, public figures)
- Places (landmarks, cities, specific locations)
- Products (brand names, specific commercial items)
- Current events or trending topics

Search grounding ensures generated images are accurate to current knowledge about these real-world subjects.

## Models & Resolutions

| Model | Speed | Max Resolution | Best For |
|-------|-------|----------------|----------|
| Flash | Fast | 1024px | Rapid iterations, exploration, high-volume |
| Pro | Moderate | 4K | Final assets, complex scenes, fine details |

**Resolution options (pro model only):** 1K (draft), 2K (quality), 4K (maximum detail)

## Supported Aspect Ratios

`square`, `landscape`, `portrait`, `1:1`, `2:3`, `3:2`, `3:4`, `4:3`, `4:5`, `5:4`, `9:16`, `16:9`, `21:9`

For aspect ratio details and use cases, see [references/prompts.md](references/prompts.md#aspect-ratio-guidelines).

## Prompt Guidance

Write specific, detailed prompts for best results.

**Good prompt:** "A minimalist geometric pattern with overlapping translucent circles in coral, teal, and gold on deep navy background, suitable for a fintech landing page hero"

**Avoid:** "A nice background"

**Key elements:** Include subject, style, colors, mood, context, and technical details (aspect ratio, transparency).

For comprehensive prompt examples and categories (pixel art, 3D, abstract, photography, UI/UX), see [references/prompts.md](references/prompts.md).

## Output Location

**Single generation:** If `--output` is omitted, saves to `assets/generated_<timestamp>.png` in the current working directory (auto-creates `assets/` directory if needed)

**Batch generation:** Requires `--dir` flag; creates the directory if it doesn't exist and saves files with sequential naming (`prefix-01.png`, `prefix-02.png`, etc.)

**Recommended:** Always use `assets/` subdirectory to keep generated images organized alongside your project

## Best Practices

1. **Choose the right model:** Flash for iterations/exploration, Pro for final assets or high-resolution needs
2. **Batch exploration:** Generate 10-20 variations to explore options, iterate on best results
3. **Rate limiting:** Use 3-5 second delays for batch generation, or reduce with `--parallel` for concurrent requests
4. **Search grounding:** Enable for real-world accuracy with landmarks, products, or specific people
5. **Resolution management:** Flash is always 1024px; use Pro's 1K/2K/4K based on quality needs

## Integration with Frontends

**HTML:** `<img src="./assets/hero-image.png" alt="Description" />`

**React:** `import img from './assets/hero-image.png'; <img src={img} alt="Description" />`

**CSS Background:** `background-image: url('./assets/hero-image.png');`

## References

- [Example Commands](references/examples.md) - Concrete command examples for all features
- [Prompt Reference](references/prompts.md) - Comprehensive prompt categories, modifiers, and patterns
- [Google Gemini Docs](https://ai.google.dev/docs) - Official API documentation
- [UV Package Manager](https://docs.astral.sh/uv/) - Package manager documentation

## Troubleshooting

**"GEMINI_API_KEY not set"**
```bash
export GEMINI_API_KEY='your-key'
# OR create .env file: GEMINI_API_KEY=your-key
```

**"Content blocked by safety filters"** - Prompt references sensitive content; try rephrasing or using fictional descriptions.

**"Rate limit exceeded"** - Increase `--delay` between batches or use `--parallel` for concurrent requests. Wait a few seconds and retry.

**"No image in response"** - Prompt may be too vague; be specific about style and details. Check API quota at [Google AI Studio](https://aistudio.google.com/).
