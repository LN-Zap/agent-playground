# AI Examples

Prompt templates and examples for Nano Banana (Gemini) image editing.

## Critical: Using Reference Images

**Always pass the rendered image as the `--reference` parameter.** This tells Nano Banana to edit the existing image rather than generate a new one from scratch.

```bash
uv run scripts/image.py \
  --prompt "Your edit prompt here" \
  --reference "path/to/rendered-design.png" \
  --output "path/to/variation.png"
```

Without `--reference`, Nano Banana generates a completely new image and ignores your rendered design.

---

## Configuration

Use the **pro model** for:
- Fine textures (halftone patterns, gradients, noise)
- Detailed graphics with small elements
- Precision-critical edits

---

## Template Categories

### 1. Color/Palette Changes

**Simple color change:**
```
Recolor the [ELEMENT] from [ORIGINAL COLOR] to [TARGET COLOR].
Keep all other elements unchanged.
```

**Precise color change (when preservation is critical):**
```
Recolor ONLY the [EXACT ELEMENT DESCRIPTION] from [ORIGINAL COLOR] to [TARGET COLOR].

PRESERVE EXACTLY:
- The [TEXTURE TYPE] texture - do NOT make it solid
- The [SHAPE/ORIENTATION]

DO NOT CHANGE:
- [ELEMENT 1]: Keep [COLOR/STATE]
- [ELEMENT 2]: Keep [COLOR/STATE]

The ONLY change should be the COLOR of [ELEMENT] becoming [TARGET COLOR].
```

### 2. Style Transformations

**Aesthetic change:**
```
Transform this image to have a [STYLE] aesthetic.

Apply [STYLE] characteristics to: [ELEMENTS TO CHANGE]

PRESERVE:
- All text must remain readable
- Logo/brand elements keep their shape
- [SPECIFIC ELEMENTS TO KEEP]
```

**Examples:**
- "vintage 1970s" - warm tones, grain, faded colors
- "minimalist modern" - clean lines, limited palette
- "neon cyberpunk" - bright colors, glowing effects
- "hand-drawn sketch" - line art, pencil texture

### 3. Background Modifications

**Background replacement:**
```
Replace the background with [NEW BACKGROUND DESCRIPTION].

Keep ALL foreground elements exactly as they are:
- [ELEMENT 1]
- [ELEMENT 2]
- [ELEMENT 3]

Only the background should change.
```

**Background enhancement:**
```
Modify the background to [CHANGE DESCRIPTION].
Example: "add a subtle gradient", "make it darker", "add blur"

Do not alter any foreground elements.
```

### 4. Element Modifications

**Add accessories/items to character:**
```
Add stylish sunglasses and gold hoop earrings to the main character.

Keep the character's face, expression, and pose exactly the same.
Integrate accessories naturally with the existing style.
Do not change: background, clothing, other elements.
```

**Add element:**
```
Add [ELEMENT DESCRIPTION] to the image at [POSITION].

Integrate naturally with existing elements.
Do not alter: [LIST EXISTING ELEMENTS]
```

**Remove element:**
```
Remove the [ELEMENT DESCRIPTION] from the image.
Fill the area naturally to match the surrounding context.
Keep all other elements unchanged.
```

**Modify element:**
```
Change the [ELEMENT] to [NEW DESCRIPTION].
Example: "change the t-shirt to a hoodie", "make the button rounded"

Preserve:
- Overall composition
- [ELEMENTS TO KEEP UNCHANGED]
```

---

## Prompt Engineering Tips

### DO

- Use CAPS for critical constraints: ONLY, PRESERVE, DO NOT
- Describe elements precisely before stating the change
- Be explicit about what to preserve AND what to change
- List negatives explicitly ("do NOT change the background")
- Describe textures when relevant: "halftone pattern", "gradient", "texture"
- Be specific about colors: "vibrant orange-gold" not just "orange"

### DON'T

- Assume the AI understands implicit constraints
- Use vague descriptions like "the logo" without specifics
- Forget to mention elements you want preserved
- Leave preservation instructions only in the negative form

---

## Iteration Strategy

Expect 1-2 iterations for complex edits. If the first result has issues:

| Problem | Solution |
|---------|----------|
| AI changed shape | Add more shape description to PRESERVE section |
| AI lost texture | Emphasize texture name, add "do NOT simplify" |
| AI changed other elements | Add them explicitly to DO NOT CHANGE |
| Color is wrong shade | Be more specific (e.g., "vibrant orange-gold, not brown") |
| Style not applied correctly | Describe style characteristics more explicitly |
| Background too different | Describe what to keep about current background |

---

## When to Use Browser-based Instead

If iterating multiple times without success, consider browser-based techniques:

| Symptom | Use Browser-based |
|---------|-------------------|
| AI keeps changing element shape | CSS preserves exact pixels |
| AI simplifies textures/patterns | CSS preserves exact patterns |
| Need reproducible results | CSS/HTML is deterministic |
| Element is an isolated image | CSS can target specific elements |
| Same variation needed repeatedly | Browser-based is instant, no API cost |
