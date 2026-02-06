---
name: brand-guidelines
description: >-
  Applies Strike's official brand identity to visual artifacts including
  presentations, web pages, dashboards, diagrams, and AI-generated images. Use
  when brand colors, typography, logo usage, or Strike's "Neo-Industrial
  Fintech" aesthetic applies. Triggers on requests for Strike styling, dark mode
  UI, brand consistency, or visual design following company standards.
---
# Strike Brand Guidelines

## Overview

Strike's visual identity is **aggressive, bold, and rooted in Bitcoin culture**. Unlike traditional "clean fintech" (blue, white, safe), Strike feels like a high-end streetwear label meets hardware startup.

**Keywords**: branding, corporate identity, visual identity, dark mode, styling, brand colors, typography, Strike brand, visual design, presentations, web design, UI

## Brand Aesthetic: "Neo-Industrial Fintech"

**Key Vibes**: Unapologetic, Fast, Global, Sovereign, High-Signal.

**Visual Logic**:
- OLED Black backgrounds as the foundation
- Stark white typography for maximum contrast
- Accent colors used deliberately and sparingly
- Heavy dark mode preference - light mode is secondary

## Color System

### Dark Mode (Primary)

**Backgrounds & Layers:**
| Token | Hex | Usage |
|-------|-----|-------|
| `Layer/background` | `#000000` | Root background (true OLED black) |
| `Layer/primary` | `#1E1E1E` | Cards, tiles, menus |
| `Layer/secondary` | `#2E2E2E` | Elevated surfaces, buttons |
| `Layer/tertiary` | `#3E3E3E` | Highest elevation |

**Text & Icons (Face):**
| Token | Hex | Usage |
|-------|-----|-------|
| `Face/primary` | `#FFFFFF` | Primary text, icons |
| `Face/secondary` | `#FFFFFFA3` | Secondary text (64% opacity) |
| `Face/tertiary` | `#FFFFFF7A` | Tertiary/muted text (48% opacity) |

**Accent Colors:**
| Token | Hex | Usage |
|-------|-----|-------|
| `Face/accent` | `#FFD4D4` | Brand accent (Rose) |
| `Face/positive` | `#42B852` | Success states |
| `Face/negative` | `#EB5842` | Error states |
| `Face/warning` | `#FFA666` | Warning states |
| `Purple` | `#7B61FF` | Special emphasis |

**Objects & Interactive Elements:**
| Token | Hex | Usage |
|-------|-----|-------|
| `Object/primary` | `#FFFFFF` | Primary interactive elements |
| `Object/secondary` | `#2E2E2E` | Secondary buttons, inputs |
| `Object/accent` | `#FFD4D4` | Accent interactive elements |

**Borders:**
| Token | Hex | Usage |
|-------|-----|-------|
| `Border/primary` | `#2E2E2EA3` | Standard borders (64% opacity) |
| `Border/secondary` | `#2E2E2E` | Solid borders |
| `Border/accent` | `#FFD4D4` | Accent borders |

### Light Mode (Secondary)

**Backgrounds & Layers:**
| Token | Hex | Usage |
|-------|-----|-------|
| `Layer/background` | `#FCFCFC` | Root background |
| `Layer/primary` | `#F5F5F5` | Cards, tiles, menus |
| `Layer/secondary` | `#EBEBEB` | Elevated surfaces |
| `Layer/tertiary` | `#D1D1D1` | Highest elevation |

**Text & Icons (Face):**
| Token | Hex | Usage |
|-------|-----|-------|
| `Face/primary` | `#050505` | Primary text, icons |
| `Face/secondary` | `#050505B8` | Secondary text (72% opacity) |
| `Face/tertiary` | `#050505A3` | Tertiary text (64% opacity) |
| `Face/accent` | `#471414` | Brand accent (deep rose) |
| `Face/positive` | `#2E994A` | Success states |
| `Face/negative` | `#EA2525` | Error states |

## Typography

**Font Family**: Strike Diatype (proprietary)
- Fallback: Inter, system-ui, sans-serif

**Type Scale:**
| Style | Font | Size | Line Height | Weight |
|-------|------|------|-------------|--------|
| Title 02 | Strike Diatype Medium | 32px | 36px | 500 |
| Title 03 | Strike Diatype Medium | 20px | 24px | 500 |
| Body 01 | Strike Diatype | 20px | 28px | 400 |
| Body 02 | Strike Diatype | 16px | 24px | 400 |

**Typography Rules:**
- Headings use medium weight (500)
- Body text uses regular weight (400)
- Letter spacing: 0 (no tracking adjustments)
- All caps for logo wordmarks only

### Typography Design Principles

Professional typography requires intentional control over rhythm, flow, and hierarchy. Never let default browser behavior determine line breaks or visual structure.

**Line Break Control:**
- **Widows/Orphans**: Never leave a single word hanging on its own line. If a sentence breaks awkwardly, rewrite or use `&nbsp;` to keep phrases together
- **Semantic Breaks**: Line breaks should occur at natural pause points (between clauses, after punctuation) not mid-phrase
- **Contrast Pairs**: When using "Not X. / Y." patterns, always break between the negative and positive statement:
  ```
  Not prompt engineering.
  Systems Engineering.
  ```

**Visual Rhythm:**
- **Scanning Hierarchy**: Text should be scannable in 3 seconds. Lead with the key point; elaborate below
- **Breathing Room**: Use consistent vertical spacing (`space-6`, `space-8`) between text blocks
- **Information Density**: Presentations are not documents. Ruthlessly cut verbose phrases ("We are establishing" → "Establishing")

**Weight for Emphasis:**
- Use `font-weight: 600` (semi-bold) for stress words within body text
- Combine weight with accent color for maximum emphasis
- Base heading weight should be lighter (400) when stress words use heavier weight (600) to create contrast

**Holistic Constraints:**
- Typography decisions must fit the container. Don't solve for typography and break layout
- If adding line breaks increases vertical height beyond available space, reduce font size or cut copy
- Always preview at actual presentation scale (not zoomed in code editor)

**Anti-patterns (Typography):**
- Letting text flow naturally and break wherever the browser decides
- Using `<br>` to force breaks at random points
- Breaking in the middle of a noun phrase ("AI / Enablement" should be "AI Enablement")
- Orphaned prepositions ("invest in / Applied Capability" should be "invest in Applied Capability")
- Single-word lines at the end of paragraphs
- Unequal line lengths that create a ragged, unbalanced appearance

### Presentation Typography (Slide Decks)

**CRITICAL**: Presentations require larger text for readability at distance and on projected screens.

**Minimum Sizes (1080p/1920x1080 slides):**
| Purpose | Minimum Size | Recommended |
|---------|--------------|-------------|
| Hero/Title | 72px+ | 96px |
| Section Headers | 48px+ | 72px |
| Body Text | 28px+ | 32px |
| Supporting Text | 24px+ | 28px |
| Captions/Labels | 20px | 24px |

**Never use below 20px** for any slide content that needs to be read. Sizes below 20px are reserved for speaker notes and UI chrome only.

**Presentation Type Scale:**
| Token | Size | Usage |
|-------|------|-------|
| `--font-size-display` | 96px | Hero headlines |
| `--font-size-5xl` | 72px | Slide headings |
| `--font-size-4xl` | 48px | Subheadings |
| `--font-size-3xl` | 32px | Body prominent |
| `--font-size-2xl` | 28px | Body text |
| `--font-size-xl` | 24px | Minimum readable |
| `--font-size-lg` | 20px | Tertiary (minimum) |

**Anti-patterns (Avoid):**
- Using `font-size-base` (16px) for slide content
- Using `font-size-sm` (14px) or smaller for anything visible
- Dense text blocks that require squinting

## Accessibility & Contrast

### WCAG Compliance

Strike follows WCAG 2.1 AA guidelines for text contrast:
- **Normal text (< 24px)**: Minimum 4.5:1 contrast ratio
- **Large text (≥ 24px)**: Minimum 3:1 contrast ratio

### Dark Mode Text Tokens (Contrast on #000000 Black)

| Token | Value | Contrast Ratio | Use For |
|-------|-------|----------------|---------|
| `--face-primary` | #FFFFFF (100%) | 21:1 | Primary text, headings |
| `--face-secondary` | rgba(255,255,255,0.64) | ~10.5:1 | Secondary text, descriptions |
| `--face-tertiary` | rgba(255,255,255,0.48) | ~7:1 | Tertiary text, supporting info |
| `--face-disabled` | rgba(255,255,255,0.32) | ~4.5:1 | Inactive/disabled states ONLY |

### Critical Rules

1. **Never use `--face-disabled` for readable text** - it's for inactive UI states only
2. **Use `--face-tertiary` as minimum** for any text that needs to be read
3. **Presentation text should use `--face-primary` or `--face-secondary`** for maximum readability
4. **Test contrast** - if you have to squint or lean in, it's too low

### Light Mode Equivalents

| Token | Value | Contrast Ratio |
|-------|-------|----------------|
| `--face-primary` | #050505 | 21:1 |
| `--face-secondary` | rgba(5,5,5,0.72) | ~12:1 |
| `--face-tertiary` | rgba(5,5,5,0.64) | ~10:1 |

## Logo System

### Primary Logos
- **Symbol**: Lightning bolt icon in rounded square container
- **Wordmark**: "STRIKE" in all caps, bold sans-serif
- **Combination A**: Symbol + Wordmark (horizontal)
- **Combination B**: Alternative combination layout

### Product Sub-brands
Each uses the Symbol + product name:
- **BLACK** - Premium tier
- **LEARN** - Educational content
- **PRIVATE** - Private banking
- **BUSINESS** - Enterprise/B2B

### Logo Usage Rules
1. White logos on dark backgrounds (preferred)
2. Black logos on light backgrounds (when necessary)
3. Maintain clear space equal to symbol height
4. Never modify, rotate, or distort the logo
5. Minimum size: 24px height for digital

### Logo Assets

Available in `assets/`:
- `Symbol.svg` - Lightning bolt icon
- `Wordmark.svg` - "STRIKE" text only
- `Combination A.svg` - Symbol + Wordmark horizontal
- `Combination B.svg` - Alternative combination
- `App.svg` - App badge

## Visual Motifs

| Motif | Concept | Implementation |
|-------|---------|----------------|
| **Lightning** | Speed, L2 Network | Electric arcs, neon filaments, light trails |
| **Globe** | Global Payments | Wireframe globe, connected nodes, orbital view |
| **Mobile** | The App | Floating smartphone, bezel-less device |
| **Bitcoin** | The Asset | Abstract gold coin, cryptographic hash |

## Imagery Style

**Texture**: Matte, smooth, premium tactile feel. Avoid glossy Web2 aesthetics.

**Lighting**: Studio lighting, high contrast, rim lighting to separate elements from dark backgrounds.

**Composition**: Centered, symmetrical, heroic.

## AI Image Generation Prompts

### Prompt Components

**Adjectives (The Look):**
- `Matte black finish`
- `High contrast`
- `OLED deep blacks`
- `Minimalist`
- `Dieter Rams inspired`
- `Tactile`
- `Premium material`

**Lighting & Ambience:**
- `Studio lighting`
- `Rim light`
- `Volumetric fog` (subtle)
- `Cyberpunk` (but clean)
- `Cinematic composition`
- `8k resolution`

**Negative Prompts (Always Include):**
`--no blue, corporate memphis, cartoon, low poly, watercolor, pastel colors, clutter, messy, grunge`

### Example Prompts

**Lightning Network Visual:**
```
A glowing bolt of yellow lightning striking a matte black stone surface, high speed photography, freeze frame, stark contrast, OLED black background, minimalist, photorealistic, 8k --ar 16:9
```

**Global Payments:**
```
A mesmerizing 3D wireframe globe made of white optical fiber lines spinning in a void, sharp focus, depth of field, connected nodes glowing orange, data flow, tech-noir aesthetic, pitch black background --ar 16:9
```

**App Experience:**
```
Close up macro shot of a premium smartphone screen displaying a "Payment Sent" notification, sleek device, dark mode UI, glowing green success checkmark, studio product photography, soft rim lighting, minimalist --ar 4:5
```

## Quality Checklist

When creating Strike-branded visuals:

- [ ] **Is it Black?** Background should be dark (light mode only when required)
- [ ] **Is it Minimal?** Remove background clutter
- [ ] **Does it pop?** Sharp contrast between subject and darkness
- [ ] **Correct tokens?** Using official hex codes, not approximations
- [ ] **Typography correct?** Strike Diatype or appropriate fallback
- [ ] **Logo usage?** White on dark, proper spacing

## References

For complete token definitions, see:
- [references/dark-tokens.md](references/dark-tokens.md) - Complete dark mode token system
- [references/light-tokens.md](references/light-tokens.md) - Complete light mode token system
- [references/primitives.md](references/primitives.md) - Primitive color palette with CSS/Tailwind snippets
- [references/typography.md](references/typography.md) - Complete typography system with all type scales
- [references/icons.md](references/icons.md) - Complete icon library with categories and naming
- [references/spacing.md](references/spacing.md) - Spacing system with 4px base unit scale
