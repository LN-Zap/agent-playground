# Nano Banana Pro - Prompt Reference Guide

## Prompt Structure

A good prompt typically includes:
1. **Subject** - What to generate
2. **Style** - Artistic style or aesthetic
3. **Details** - Lighting, colors, composition
4. **Quality** - Resolution hints, professional quality

## Categories

### Pixel Art / 8-bit

```
Pixel art {subject}, 8-bit retro style, limited color palette, 
crisp pixels, nostalgic video game aesthetic
```

**Examples:**
```
Pixel art robot mascot, 8-bit style, blue and orange colors, 
friendly expression, transparent background

Pixel art landscape, retro video game style, sunset colors, 
16-bit era aesthetic, side-scrolling game background

Pixel art food icons, 8-bit style, bright colors, 
game UI elements, clean pixel edges
```

### 3D / Isometric

```
3D render of {subject}, isometric view, {style},
soft shadows, {colors}, clean background
```

**Examples:**
```
3D isometric office workspace, low poly style,
pastel colors, soft shadows, cute aesthetic

3D render of floating island, isometric perspective,
fantasy environment, vibrant colors, game asset style

Isometric city block, architectural visualization,
modern buildings, clean lines, professional render
```

### Abstract / Artistic

```
Abstract {subject}, {style} style, {colors},
{texture}, artistic composition
```

**Examples:**
```
Abstract fluid art, vibrant colors, marble texture,
flowing shapes, high contrast, contemporary style

Abstract geometric pattern, bauhaus style,
primary colors, sharp edges, modernist aesthetic

Abstract landscape, impressionist style,
soft brushstrokes, dreamy atmosphere, oil painting texture
```

### Photography / Realistic

```
{Subject} in {environment}, {style} photography,
{lighting}, {mood}, {camera/lens style}
```

**Examples:**
```
A serene Japanese garden with cherry blossoms,
warm natural lighting, spring morning, soft focus background,
professional photography, 35mm film aesthetic

Cozy coffee shop interior, warm overhead lighting,
vintage wooden furniture, plants on shelves,
soft bokeh background, cinematic composition

Mountain landscape at sunset, dramatic golden light,
distant snow-capped peaks, foreground wildflowers,
cinematic photography, wide angle lens
```

### Illustration / Digital Art

```
{Subject} illustration, {style} style, 
{colors}, {mood}, digital art
```

**Examples:**
```
A whimsical fairy tale castle, storybook illustration style,
soft pastel colors, magical glowing lights, enchanted forest

Character portrait of a medieval knight, detailed illustration,
serious expression, ornate armor, dramatic lighting,
professional character design art
```

### UI/UX Elements

```
{Element} icon, {style} style, {size/format},
{colors}, minimal design
```

**Examples:**
```
User avatar icon, outline style, circular, 
simple geometric shapes, blue and white colors,
app UI icon, professional design

Navigation menu button, flat design, rounded corners,
gradient background, white text, interactive element,
modern minimalist style
```

## Quality Modifiers

### Resolution Hints
- "high resolution"
- "4K quality"
- "ultra detailed"
- "sharp focus"
- "crisp details"

### Professional Quality
- "professional photograph"
- "studio quality"
- "commercial grade"
- "publication ready"
- "award winning"

### Style Consistency
- "consistent style"
- "cohesive aesthetic"
- "unified color palette"
- "matching visual language"

## Aspect Ratio Guidelines

| Ratio | Use Case | Description |
|-------|----------|-------------|
| 1:1 | Icons, avatars, social posts | Square composition, centered subject |
| 2:3 | Portrait photos, book covers | Portrait orientation, full body framing |
| 3:2 | Landscape photos, prints | Landscape orientation, wide horizontal |
| 3:4 | Tall portrait, phone wallpapers | Very tall, portrait smartphone format |
| 4:3 | Presentations, traditional media | Standard presentation aspect ratio |
| 4:5 | Portrait prints, Instagram | Photo print standard, slightly tall |
| 5:4 | Landscape prints, panels | Landscape print standard |
| 9:16 | Mobile stories, Reels, TikTok | Vertical video format, tall screen |
| 16:9 | YouTube, widescreen, banners | Widescreen standard, cinematic |
| 21:9 | Ultra-wide, cinematic, panoramic | Cinema scope, ultra-wide panoramic |

## Negative Concepts (What NOT to include)

Instead of telling the model what NOT to do, describe what you want clearly:

**Instead of:** "no text"
**Use:** "clean image without text, pure visual"

**Instead of:** "no people"
**Use:** "empty scene, unpopulated environment"

**Instead of:** "not blurry"
**Use:** "sharp focus, crisp details, high clarity"

**Instead of:** "no watermarks"
**Use:** "clean, professional, no branding visible"

## Batch Generation Tips

When generating multiple variations:

1. **Keep core prompt consistent** - Same subject and style
2. **Vary specific details** - Colors, poses, backgrounds
3. **Use numbered batches** - Track which prompts work best
4. **Iterate on winners** - Refine prompts that produce good results

**Example batch workflow:**
```bash
# Round 1: Explore styles
"pixel art robot, 8-bit style, blue colors"
"pixel art robot, retro game style, warm colors"
"pixel art robot, modern pixel art, neon colors"

# Round 2: Refine best style
"pixel art robot, 8-bit style, blue and silver colors, friendly expression"
"pixel art robot, 8-bit style, blue and gold colors, heroic pose"
```

## Image Editing Tips

When editing existing images, provide clear instructions:

**Style Transfer:**
- "Convert this to watercolor painting style"
- "Make this look like a Van Gogh painting"
- "Apply a noir film noir aesthetic"

**Content Modification:**
- "Add a rainbow in the sky"
- "Replace the background with a forest"
- "Remove the person and fill with landscape"

**Appearance Changes:**
- "Make the colors more vibrant"
- "Apply a black and white filter"
- "Increase the contrast and add dramatic lighting"

**Composition:**
- "Zoom in on the subject"
- "Add more space on the left side"
- "Reposition the subject to the rule of thirds"

## Search Grounding Examples

Use the `--search` flag for factually accurate images of:

- **Real people:** Specific celebrities, historical figures, public figures
- **Places:** Specific landmarks, cities, geographical locations
- **Products:** Brand names, specific products, commercial items
- **Current events:** Recent news, trending topics
- **Organizations:** Logos, headquarters, official imagery

**Examples:**
```bash
# Landmark with accurate details
"The Eiffel Tower at sunset with Paris skyline"

# Celebrity portrait (with search grounding)
"Portrait of a famous actor in professional headshot style"

# Product visualization
"Apple iPhone 15 Pro Max in Desert Titanium color"

# Organization logo style
"Google logo redesigned in 3D isometric style"
```

## Common Prompting Patterns

### Character Design
```
[Character description], [expression/pose], [clothing/armor details],
[art style], [lighting], character design illustration
```

**Example:**
```
A young wizard character with long silver hair, confident smiling expression,
wearing ornate purple robes with gold trim, magical staff in hand,
professional fantasy character illustration, dramatic lighting,
concept art style
```

### Environment / Scene
```
[Environment description], [time of day/season], [mood/atmosphere],
[style/aesthetic], [camera angle], [lighting]
```

**Example:**
```
A sprawling fantasy city with grand architecture and bustling streets,
golden hour lighting, peaceful evening atmosphere, vibrant colors,
isometric game art style, wide establishing shot, cinematic composition
```

### Product Showcase
```
[Product], [angle/presentation], [context/setting],
[style], [lighting], [render quality]
```

**Example:**
```
A sleek modern desk lamp on a wooden desk, three-quarter view,
minimalist office setting, soft studio lighting,
product photography, professional render, clean white background
```

### Pattern / Design Element
```
[Pattern type], [colors], [scale/density], [texture], [style]
```

**Example:**
```
Geometric hexagon pattern, blues and teals, medium density,
metallic texture with subtle depth, modern minimalist style,
seamless repeating pattern
```
