---
name: generating-figma-variations
description: Generate variations of Figma designs by rendering them locally and applying modifications. Use for design variations, color alternatives, style changes, background modifications, or element transformations. Triggers on requests involving Figma designs that need variations, mockups, or visual modifications.
---

# Figma to Variations

Generate variations of Figma designs using browser-based techniques (deterministic) or generative AI (flexible).

## Prerequisites

**Before starting, load these skills:**

1. **figma-implement-design skill** (REQUIRED) - Load this skill for Phase 1 of this workflow. It ensures pixel-perfect Figma fetching and asset handling.

2. **generating-images skill** (if using AI technique) - Load for Nano Banana AI image editing

**Also required:**
- **Playwright MCP** - For rendering HTML and taking screenshots

## Technique Selection

| Technique | Best For | Tradeoffs |
|-----------|----------|-----------|
| **Browser-based** | Color shifts, visibility, transforms, swaps | Limited to CSS/HTML |
| **Generative AI** | Style changes, backgrounds, semantic edits | May need iteration |

**Use Browser-based** for isolated elements, deterministic results, pixel preservation.

**Use Generative AI** for style/artistic changes, backgrounds, semantic edits, embedded elements.

---

## Workflow

### Phase 0: Clarify Requirements

Before starting, assess if the request is specific enough. Vague requests lead to wasted iterations.

**Requirements checklist:**
- [ ] Target Figma design/node identified
- [ ] Specific changes clearly described (not "make it look better")
- [ ] Elements to preserve explicitly stated
- [ ] Number and types of variations defined
- [ ] Output format/location specified

**If requirements are unclear:**

Use the **conducting-interviews skill** (if available) to probe the user:

1. Ask ONE clarifying question at a time
2. Focus on the specific change: "What exactly should change? What color, style, or element?"
3. Clarify preservation: "What elements must remain exactly the same?"
4. Confirm scope: "How many variations? What range of options?"

**Example probing questions:**
- "You mentioned color variations - what specific colors? Brand colors, or explore options?"
- "Should the logo shape/texture stay exactly the same, or can it be simplified?"
- "Are there elements that must NOT change under any circumstances?"

**If requirements are already clear:** Skip this phase and proceed.

### Phase 1: Fetch Design & Render Using figma-implement-design Skill

**IMPORTANT: You MUST load and follow the figma-implement-design skill for this phase.**

1. **Load the figma-implement-design skill**
2. **Follow Steps 1-4** from that skill exactly:
   - Step 1: Get Node ID (parse from URL or use desktop selection)
   - Step 2: Fetch Design Context (`get_design_context`)
   - Step 3: Capture Visual Reference (`get_screenshot`)
   - Step 4: Download Required Assets

**Critical**: The figma-implement-design skill ensures pixel-perfect translation. Do NOT skip loading it or try to implement a simpler version.

**Critical**: Download ALL assets locally - Figma MCP localhost URLs are ephemeral.

After completing Steps 1-4 from figma-implement-design, create an HTML file referencing local assets and serve via HTTP (Playwright blocks `file://`). Use Playwright MCP to screenshot the rendered design as your base image.

### Phase 2: Generate Variations

Choose technique and apply modifications.

---

## Technique A: Browser-based Modifications

For deterministic, pixel-perfect changes. See `references/browser-examples.md` for complete patterns.

**Supported modifications:**
- Color shifts (CSS filters)
- Visibility toggles
- Transforms (scale, rotate, position)
- Component/asset swaps

**Workflow:** Create HTML → Define CSS classes → Playwright apply + screenshot → Repeat

---

## Technique B: Generative AI Modifications

Use **Nano Banana skill** for changes CSS can't express. See `references/ai-examples.md` for prompt templates.

**Critical**: Pass the rendered image as the `--reference` parameter so Nano Banana edits it rather than generating from scratch.

**Supported modifications:**
- Color/palette changes on embedded elements
- Style transformations (vintage, modern, etc.)
- Background replacement
- Element additions/removals (e.g., "put sunglasses on the character")
- Texture/material changes

**Workflow:** Render → Use reference image with Nano Banana → Describe changes explicitly

---

## Validation & Iteration

### Validation by Technique

**Browser-based:** Use Playwright to screenshot each CSS class variation.

**AI-based:** Output images are saved directly to disk. **Do NOT open a browser or web server to validate AI outputs.** Simply inspect the generated image files.

### After Each Variation

1. **Compare to original** - View both images (original render and variation)
2. **Check preservation** - Verify elements that should be unchanged ARE unchanged
3. **Check modification** - Verify the requested change was applied correctly

### If Validation Fails (AI Technique)

Follow this iteration loop:

```
1. Identify what went wrong:
   - [ ] AI changed elements it shouldn't have
   - [ ] AI didn't apply the change correctly
   - [ ] AI generated new image instead of editing
   - [ ] AI simplified textures/patterns

2. Refine prompt based on failure:
   - If wrong elements changed → Add explicit DO NOT CHANGE list
   - If change incorrect → Be more specific about target color/style
   - If new image generated → Verify --reference parameter is set
   - If textures simplified → Use pro model, add "preserve texture" instruction

3. Re-run with refined prompt

4. Repeat until validation passes (max 3 iterations)
```

### If AI Fails After 2-3 Iterations

Switch to browser-based technique if possible:
- Color changes → CSS filters preserve pixels exactly
- Visibility → CSS display/opacity is deterministic
- Position/scale → CSS transforms are precise

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Asset doesn't match Figma | Use actual Figma assets |
| Assets disappear | Download locally before closing Figma |
| Playwright blocks file:// | Serve via HTTP server (`python -m http.server PORT`) |
| Port already in use | Try different port or kill with `lsof -ti:PORT \| xargs kill -9` |
| Screenshot fails "must have required property 'type'" | Add `type="png"` parameter |
| Evaluate fails "must have required property 'function'" | Use `function="() => { ... }"` syntax |
| AI changes unintended elements | Use browser-based, or expand AI prompt |
| AI generates new image instead of editing | Pass image as `--reference` parameter |

**See `references/browser-examples.md`** for detailed Playwright MCP tool syntax and troubleshooting.

---

## References

- `references/browser-examples.md` - CSS/JS patterns and color mapping
- `references/ai-examples.md` - Prompt templates for AI edits
