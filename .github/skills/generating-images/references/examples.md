# Nano Banana Pro - Usage Examples

## Single Image Generation

### Basic Generation
```bash
uv run skills/generating-images/scripts/image.py \
  --prompt "A serene Japanese garden with cherry blossoms"
```

### Pro Model with High Resolution
```bash
uv run skills/generating-images/scripts/image.py \
  --prompt "A detailed hero illustration for a tech landing page" \
  --model pro \
  --size 4K \
  --aspect 16:9 \
  --output "hero-illustration.png"
```

### Specific Aspect Ratio
```bash
uv run skills/generating-images/scripts/image.py \
  --prompt "A cinematic ultra-wide landscape" \
  --aspect 21:9 \
  --model pro \
  --size 2K \
  --output "cinematic.png"
```

## Image Editing

### Style Transfer
```bash
uv run skills/generating-images/scripts/image.py \
  --prompt "Convert this to a watercolor painting style with soft colors" \
  --reference "photo.jpg" \
  --output "watercolor.png"
```

### Content Modification
```bash
uv run skills/generating-images/scripts/image.py \
  --prompt "Remove the person and replace with a forest background" \
  --reference "photo.jpg" \
  --output "edited.png"
```

### Common Editing Tasks
- **Style transfer:** "Make it look like a Van Gogh painting" or "Apply noir film aesthetic"
- **Content modification:** "Add a rainbow in the sky" or "Replace the background with a forest"
- **Appearance changes:** "Make colors more vibrant" or "Increase contrast with dramatic lighting"
- **Composition:** "Zoom in on the subject" or "Reposition the subject to the rule of thirds"

## Google Search Grounding

### Landmarks
```bash
uv run skills/generating-images/scripts/image.py \
  --prompt "The Eiffel Tower at sunset with Paris skyline" \
  --search \
  --output "landmark.png"
```

### Products
```bash
uv run skills/generating-images/scripts/image.py \
  --prompt "Apple iPhone 15 Pro in Desert Titanium color, product photo" \
  --search \
  --output "iphone.png"
```

### Celebrity/Public Figures
```bash
uv run skills/generating-images/scripts/image.py \
  --prompt "Portrait of a famous actor in professional headshot style" \
  --search \
  --model pro \
  --output "headshot.png"
```

## Batch Generation

### Pixel Art Variations
```bash
uv run skills/generating-images/scripts/batch_generate.py \
  "pixel art robot, 8-bit style" \
  -n 20 \
  -d ./robots \
  -p robot
```

### High-Quality Icons
```bash
uv run skills/generating-images/scripts/batch_generate.py \
  "minimalist app icon" \
  -n 15 \
  --aspect 1:1 \
  --model pro \
  --size 4K \
  -d ./icons \
  -p icon
```

### Fast Parallel Generation
```bash
uv run skills/generating-images/scripts/batch_generate.py \
  "product mockup photography" \
  -n 10 \
  --parallel 3 \
  -d ./products \
  -p product
```

### Landscape Variations
```bash
uv run skills/generating-images/scripts/batch_generate.py \
  "cinematic landscape, golden hour lighting" \
  -n 5 \
  --aspect 16:9 \
  --model pro \
  --size 2K \
  -d ./landscapes \
  -p landscape
```

## Filename Conventions

**Recommended format:** `<context-or-type>-<descriptor>.png`

Single generation examples:
- `hero-gradient-abstract.png` - for hero images
- `icon-user-avatar.png` - for icons
- `bg-pattern-geometric.png` - for backgrounds
- `product-mockup-laptop.png` - for product visuals
- `banner-tech-minimal.png` - for banners

Batch generation (auto-generated with sequential numbers):
- `robot-01.png`, `robot-02.png`, ... `robot-20.png`
- `icon-01.png`, `icon-02.png`, ... `icon-15.png`
