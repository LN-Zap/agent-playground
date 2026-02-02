# Strike Spacing System

Spacing tokens from the Strike design system, based on a 4px base unit.

## Space Scale

| Token | Value | Usage |
|-------|-------|-------|
| `Space/4` | 4px | Micro spacing, icon padding |
| `Space/8` | 8px | Tight spacing, inline elements |
| `Space/16` | 16px | Standard component padding |
| `Space/24` | 24px | Card padding, section gaps |
| `Space/32` | 32px | Section spacing |
| `Space/48` | 48px | Large section gaps |
| `Space/64` | 64px | Major section dividers |
| `Space/96` | 96px | Hero spacing |
| `Space/128` | 128px | Page section gaps |
| `Space/256` | 256px | Maximum spacing |

## Base Unit

The spacing system uses a **4px base unit**. All spacing values are multiples of 4.

```
4, 8, 16, 24, 32, 48, 64, 96, 128, 256
```

## CSS Custom Properties

```css
:root {
  --space-1: 4px;    /* 1 unit */
  --space-2: 8px;    /* 2 units */
  --space-4: 16px;   /* 4 units */
  --space-6: 24px;   /* 6 units */
  --space-8: 32px;   /* 8 units */
  --space-12: 48px;  /* 12 units */
  --space-16: 64px;  /* 16 units */
  --space-24: 96px;  /* 24 units */
  --space-32: 128px; /* 32 units */
  --space-64: 256px; /* 64 units */
}
```

## Tailwind Config

```javascript
module.exports = {
  theme: {
    spacing: {
      '0': '0px',
      '1': '4px',
      '2': '8px',
      '3': '12px',
      '4': '16px',
      '5': '20px',
      '6': '24px',
      '8': '32px',
      '10': '40px',
      '12': '48px',
      '16': '64px',
      '20': '80px',
      '24': '96px',
      '32': '128px',
      '40': '160px',
      '48': '192px',
      '56': '224px',
      '64': '256px',
    },
  },
}
```

## Usage Guidelines

### Component Spacing

| Context | Recommended Token |
|---------|-------------------|
| Icon padding | `Space/4` (4px) |
| Button padding (vertical) | `Space/8` (8px) |
| Button padding (horizontal) | `Space/16` (16px) |
| Input padding | `Space/16` (16px) |
| Card padding | `Space/24` (24px) |
| Section padding | `Space/32` - `Space/48` |
| Page margins (mobile) | `Space/16` (16px) |
| Page margins (desktop) | `Space/48` - `Space/64` |

### Layout Grid

Strike uses an 8-column grid system with 24px gaps between columns.

#### HD Layout (1280px+ viewport)

| Columns | Width |
|---------|-------|
| 8 | 1022px |
| 7 | 908px |
| 6 | 794px |
| 5 | 679px |
| 4 | 564px |
| 3 | 450px |
| 2 | 336px |
| 1 | 221px |

**Column calculation**: `width = (columns × 114px) + ((columns - 1) × 24px)`
- Base column: ~114px
- Gutter: 24px

#### Desktop Layout (1024px viewport)

| Columns | Width |
|---------|-------|
| 8 | 718px |
| 7 | 574px |
| 6 | 500px |
| 5 | 428px |
| 4 | 356px |
| 3 | 282px |
| 2 | 210px |
| 1 | 138px |

**Column calculation**: `width = (columns × 66px) + ((columns - 1) × 24px)`
- Base column: ~66px
- Gutter: 24px

#### Breakpoints

| Breakpoint | Container Width | Columns |
|------------|-----------------|---------|
| Mobile | 100% - 32px | 4 |
| Tablet | 100% - 64px | 6 |
| Desktop | 718px max | 8 |
| HD | 1022px max | 8 |

### Vertical Rhythm

- **Paragraph spacing**: `Space/24` (24px)
- **Section headings**: `Space/48` above, `Space/24` below
- **Card gaps**: `Space/16` - `Space/24`
- **List item spacing**: `Space/8` - `Space/16`

## Border Radius

Strike uses a layered radius system with three naming conventions. The **Semantic** approach is recommended for flexibility.

### Radius Scale

| Token | Value | Usage |
|-------|-------|-------|
| `radius-small` / `radius-inner` | 12px | Inner elements, small chips |
| `radius-medium` / `radius-default` | 16px | Buttons, inputs, tiles, tables |
| `radius-large` / `radius-outer` | 24px | Cards, modals, screens |

### Token Naming Conventions

**Relative (Nested Context)**
- `radius-outer`: 24px - Outermost container
- `radius-default`: 16px - Middle layer
- `radius-inner`: 12px - Innermost element
- *Note: Elegant for nested components, but context-dependent*

**Descriptive (Size-based)**
- `radius-large`: 24px
- `radius-medium`: 16px
- `radius-small`: 12px
- *Note: Uniform across components, harder to add intermediate sizes*

**Semantic (Component-based)** ✓ *Recommended*
- `radius-screens`: 24px - Full-screen containers, modals
- `radius-tiles`: 16px - Card tiles, content blocks
- `radius-tables`: 16px - Table containers
- `radius-buttons`: 12px - Buttons, interactive elements
- *Note: Most flexible and intuitive for surgical changes*

### CSS Custom Properties

```css
:root {
  /* Descriptive scale */
  --radius-sm: 12px;
  --radius-md: 16px;
  --radius-lg: 24px;
  --radius-full: 9999px;
  
  /* Semantic tokens */
  --radius-button: 12px;
  --radius-input: 12px;
  --radius-tile: 16px;
  --radius-card: 16px;
  --radius-modal: 24px;
  --radius-screen: 24px;
}
```

### Tailwind Config

```javascript
module.exports = {
  theme: {
    borderRadius: {
      'none': '0',
      'sm': '12px',
      'DEFAULT': '16px',
      'md': '16px',
      'lg': '24px',
      'full': '9999px',
    },
  },
}
```
