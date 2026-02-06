# Strike Typography System

Complete typography specifications from the Strike design system.

## Font Families

| Family | Variants | Usage |
|--------|----------|-------|
| **Strike Diatype** | Regular (400), Medium (500) | Primary typeface for all UI |
| **Strike Diatype Mono** | Medium (500) | Code, data, technical content |

### Fallbacks

```css
font-family: 'Strike Diatype', Inter, system-ui, -apple-system, sans-serif;
font-family: 'Strike Diatype Mono', 'SF Mono', 'Fira Code', monospace;
```

## Type Scale

### Large Titles (Hero/Marketing)

| Token | Size | Line Height | Weight | Usage |
|-------|------|-------------|--------|-------|
| `Large title 01` | 96px | 88px | Medium (500) | Hero headlines |
| `Large title 02` | 72px | 64px | Medium (500) | Section heroes |
| `Large title 03` | 48px | 48px | Medium (500) | Feature headlines |

### Titles (UI Headers)

| Token | Size | Line Height | Weight | Usage |
|-------|------|-------------|--------|-------|
| `Title 01` | 32px | 36px | Medium (500) | Page titles |
| `Title 02` | 24px | 28px | Medium (500) | Section titles |
| `Title 03` | 20px | 24px | Medium (500) | Card titles |
| `Title 04` | 18px | 20px | Medium (500) | Subsection titles |

### Subheadlines

| Token | Size | Line Height | Weight | Usage |
|-------|------|-------------|--------|-------|
| `Subheadline 01` | 16px | 24px | Medium (500) | Primary subheads |
| `Subheadline 02` | 14px | 20px | Medium (500) | Secondary subheads |
| `Subheadline 03` | 12px | 16px | Medium (500) | Tertiary subheads |

### Body Text

| Token | Size | Line Height | Weight | Usage |
|-------|------|-------------|--------|-------|
| `Body 01` | 20px | 28px | Regular (400) | Large body text |
| `Body 02` | 16px | 24px | Regular (400) | Standard body text |
| `Body 03` | 14px | 20px | Regular (400) | Small body text |
| `Body 04` | 12px | 16px | Regular (400) | Extra small body |

### Longform (CMS/Articles)

| Token | Size | Line Height | Weight | Usage |
|-------|------|-------------|--------|-------|
| `Body 01 Longform` | 20px | 32px | Regular (400) | Article body large |
| `Body 02 Longform` | 16px | 28px | Regular (400) | Article body standard |

### Links

| Token | Size | Line Height | Weight | Style |
|-------|------|-------------|--------|-------|
| `Body 01 Link` | 20px | 28px | Medium (500) | Underlined |
| `Body 02 Link` | 16px | 24px | Medium (500) | Underlined |
| `Body 03 Link` | 14px | 20px | Medium (500) | Underlined |
| `Body 04 Link` | 12px | 16px | Medium (500) | Underlined |

### UI Elements

| Token | Size | Line Height | Weight | Usage |
|-------|------|-------------|--------|-------|
| `Button 01` | 14px | 20px | Medium (500) | Primary buttons |
| `Button 02` | 12px | 16px | Medium (500) | Secondary buttons |
| `Caption` | 10px | 12px | Regular (400) | Captions, labels |

### Monospace

| Token | Size | Line Height | Weight | Usage |
|-------|------|-------------|--------|-------|
| `Mono 01` | 14px | 20px | Medium (500) | Code blocks, data |
| `Mono 02` | 12px | 16px | Medium (500) | Inline code, small data |

## CSS Custom Properties

```css
:root {
  /* Font Families */
  --font-sans: 'Strike Diatype', Inter, system-ui, sans-serif;
  --font-sans-medium: 'Strike Diatype Medium', Inter, system-ui, sans-serif;
  --font-mono: 'Strike Diatype Mono Medium', 'SF Mono', monospace;
  
  /* Large Titles */
  --text-large-title-01: 500 96px/88px var(--font-sans-medium);
  --text-large-title-02: 500 72px/64px var(--font-sans-medium);
  --text-large-title-03: 500 48px/48px var(--font-sans-medium);
  
  /* Titles */
  --text-title-01: 500 32px/36px var(--font-sans-medium);
  --text-title-02: 500 24px/28px var(--font-sans-medium);
  --text-title-03: 500 20px/24px var(--font-sans-medium);
  --text-title-04: 500 18px/20px var(--font-sans-medium);
  
  /* Subheadlines */
  --text-subheadline-01: 500 16px/24px var(--font-sans-medium);
  --text-subheadline-02: 500 14px/20px var(--font-sans-medium);
  --text-subheadline-03: 500 12px/16px var(--font-sans-medium);
  
  /* Body */
  --text-body-01: 400 20px/28px var(--font-sans);
  --text-body-02: 400 16px/24px var(--font-sans);
  --text-body-03: 400 14px/20px var(--font-sans);
  --text-body-04: 400 12px/16px var(--font-sans);
  
  /* Longform */
  --text-body-01-longform: 400 20px/32px var(--font-sans);
  --text-body-02-longform: 400 16px/28px var(--font-sans);
  
  /* Buttons */
  --text-button-01: 500 14px/20px var(--font-sans-medium);
  --text-button-02: 500 12px/16px var(--font-sans-medium);
  
  /* Mono */
  --text-mono-01: 500 14px/20px var(--font-mono);
  --text-mono-02: 500 12px/16px var(--font-mono);
  
  /* Caption */
  --text-caption: 400 10px/12px var(--font-sans);
}
```

## Tailwind Config

```javascript
module.exports = {
  theme: {
    fontFamily: {
      sans: ['Strike Diatype', 'Inter', 'system-ui', 'sans-serif'],
      'sans-medium': ['Strike Diatype Medium', 'Inter', 'system-ui', 'sans-serif'],
      mono: ['Strike Diatype Mono Medium', 'SF Mono', 'Fira Code', 'monospace'],
    },
    fontSize: {
      // Large Titles
      'large-title-01': ['96px', { lineHeight: '88px', fontWeight: '500' }],
      'large-title-02': ['72px', { lineHeight: '64px', fontWeight: '500' }],
      'large-title-03': ['48px', { lineHeight: '48px', fontWeight: '500' }],
      
      // Titles
      'title-01': ['32px', { lineHeight: '36px', fontWeight: '500' }],
      'title-02': ['24px', { lineHeight: '28px', fontWeight: '500' }],
      'title-03': ['20px', { lineHeight: '24px', fontWeight: '500' }],
      'title-04': ['18px', { lineHeight: '20px', fontWeight: '500' }],
      
      // Subheadlines
      'subheadline-01': ['16px', { lineHeight: '24px', fontWeight: '500' }],
      'subheadline-02': ['14px', { lineHeight: '20px', fontWeight: '500' }],
      'subheadline-03': ['12px', { lineHeight: '16px', fontWeight: '500' }],
      
      // Body
      'body-01': ['20px', { lineHeight: '28px', fontWeight: '400' }],
      'body-02': ['16px', { lineHeight: '24px', fontWeight: '400' }],
      'body-03': ['14px', { lineHeight: '20px', fontWeight: '400' }],
      'body-04': ['12px', { lineHeight: '16px', fontWeight: '400' }],
      
      // Longform
      'body-01-longform': ['20px', { lineHeight: '32px', fontWeight: '400' }],
      'body-02-longform': ['16px', { lineHeight: '28px', fontWeight: '400' }],
      
      // Buttons
      'button-01': ['14px', { lineHeight: '20px', fontWeight: '500' }],
      'button-02': ['12px', { lineHeight: '16px', fontWeight: '500' }],
      
      // Mono
      'mono-01': ['14px', { lineHeight: '20px', fontWeight: '500' }],
      'mono-02': ['12px', { lineHeight: '16px', fontWeight: '500' }],
      
      // Caption
      'caption': ['10px', { lineHeight: '12px', fontWeight: '400' }],
    },
  },
}
```

## Typography Rules

### General
- **Letter spacing**: Always 0 (no tracking adjustments)
- **Font smoothing**: Use `-webkit-font-smoothing: antialiased`
- **All caps**: Reserved for logo wordmarks only

### Hierarchy
1. Use titles (medium weight) for hierarchy and navigation
2. Use body (regular weight) for content and descriptions
3. Use subheadlines for labels and secondary headers
4. Reserve large titles for marketing/hero sections only

### Links
- Links use medium weight (500) to stand out
- Always underlined for accessibility
- Inherit size from surrounding context

### Monospace
- Use for code, technical data, amounts, and timestamps
- Always medium weight for readability
