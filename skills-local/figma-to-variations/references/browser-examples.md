# Browser-based Modification Examples

CSS and JavaScript patterns for deterministic design variations.

---

## Color Modifications (CSS Filters)

### Basic Hue Rotation

Simple hue shift (limited control):

```css
.element {
  filter: hue-rotate(180deg);
}
```

### Controlled Color Shift Pattern

For precise color control, convert to sepia baseline first:

```css
.element {
  filter: sepia(100%) saturate(N%) hue-rotate(Xdeg) brightness(N);
}
```

**How It Works:**
1. `sepia(100%)` - Converts all colors to a consistent warm/brown baseline
2. `saturate(N%)` - Amplifies color intensity (300-500% for vibrant results)
3. `hue-rotate(Xdeg)` - Rotates the hue wheel to target color
4. `brightness(N)` - Fine-tunes luminosity (1.0-1.2 typical)

### Color Reference Table

From a red/pink baseline after sepia conversion:

| Target Color | Hue Rotation | Saturation | Full Filter |
|--------------|--------------|------------|-------------|
| Orange/Gold | 0-20deg | 300% | `sepia(100%) saturate(300%) hue-rotate(5deg) brightness(1.1)` |
| Yellow | 30-50deg | 400% | `sepia(100%) saturate(400%) hue-rotate(40deg) brightness(1.05)` |
| Green | 70-100deg | 300% | `sepia(100%) saturate(300%) hue-rotate(90deg) brightness(1.0)` |
| Cyan/Blue | 140-180deg | 500% | `sepia(100%) saturate(500%) hue-rotate(160deg) brightness(1.2)` |
| Purple | 220-260deg | 400% | `sepia(100%) saturate(400%) hue-rotate(240deg) brightness(1.0)` |

---

## Visibility Toggles

### Hide/Show Elements

```css
/* Hide completely (no space) */
.hidden { display: none; }

/* Hide but preserve space */
.invisible { visibility: hidden; }

/* Fade out */
.faded { opacity: 0; }
```

### JavaScript Toggle

```javascript
// Hide element
document.querySelector('.element').style.display = 'none';

// Show element
document.querySelector('.element').style.display = 'block';
```

---

## Transform Modifications

### Scale, Rotate, Position

```css
.scaled { transform: scale(1.2); }
.rotated { transform: rotate(15deg); }
.moved { transform: translate(10px, -5px); }
.combined { transform: scale(1.1) rotate(-5deg) translate(0, 10px); }
```

### Opacity Variations

```css
.semi-transparent { opacity: 0.7; }
.very-faint { opacity: 0.3; }
```

---

## Component Swaps

### Image Source Swap

```javascript
// Swap logo
document.querySelector('.logo').src = 'alternate-logo.png';

// Swap background image
document.querySelector('.hero').style.backgroundImage = 'url(new-bg.jpg)';
```

### Text Content Swap

```javascript
document.querySelector('.headline').textContent = 'New Headline';
```

### Class-based Variations

```html
<style>
  .theme-light { background: white; color: black; }
  .theme-dark { background: black; color: white; }
</style>

<script>
  // Switch theme
  document.body.className = 'theme-dark';
</script>
```

---

## Playwright Workflow

### Apply variations via JavaScript

```javascript
// Apply color filter
document.querySelector('.logo').className = 'logo logo-orange-gold';

// Hide element
document.querySelector('.badge').style.display = 'none';

// Swap image
document.querySelector('.hero-image').src = 'variant-b.png';
```

### Playwright MCP sequence

1. Navigate to HTML page
2. Take screenshot (original/base)
3. Evaluate JavaScript to apply variation
4. Take screenshot (variation 1)
5. Evaluate JavaScript for next variation
6. Take screenshot (variation 2)
7. Repeat for each variation

---

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| Colors look washed out | Low saturation | Increase `saturate()` value (try 400-500%) |
| Colors too intense | High saturation | Reduce `saturate()` value (try 200-300%) |
| Wrong target color | Incorrect hue rotation | Adjust `hue-rotate()` degrees - see table |
| Filter affects everything | Filter on wrong element | Apply filter to specific element only |
| Element won't hide | Wrong selector | Verify selector matches element |
| Transform looks wrong | Transform origin | Set `transform-origin` to control pivot point |
