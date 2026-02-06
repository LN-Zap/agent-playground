# Strike Primitive Color Palette

The foundational colors from which all semantic tokens are derived.

## Neutral Scale

| Token | Dark Hex | Light Hex | Description |
|-------|----------|-----------|-------------|
| `Neutral/Background` | `#000000` | - | True OLED black |
| `Neutral/Primary` | `#FFFFFF` | - | Pure white |
| `Neutral/Black 07` | - | `#050505` | Near-black |
| `Neutral/Grey 06` | - | `#292929` | Darkest gray |
| `Neutral/Grey 05` | - | `#7A7A7A` | Medium-dark gray |
| `Neutral/Grey 04` | - | `#A8A8A8` | Medium gray |
| `Neutral/Grey 03` | - | `#D1D1D1` | Light-medium gray |
| `Neutral/Grey 02` | - | `#EBEBEB` | Light gray |
| `Neutral/Grey 01` | - | `#F5F5F5` | Very light gray |
| `Neutral/White 00` | - | `#FCFCFC` | Off-white |

## Rose Scale (Brand Accent)

| Token | Hex | Description |
|-------|-----|-------------|
| `Rose/Rose 01` | `#FFD4D4` | Lightest rose (dark mode accent) |
| `Rose/Rose 02` | `#EB8D8D` | Medium rose |
| `Rose/Rose 03` | `#471414` | Deep rose (light mode accent) |

## Green Scale (Positive/Success)

| Token | Hex | Description |
|-------|-----|-------------|
| `Green/Green 01` | `#D9FCE2` | Lightest green (backgrounds) |
| `Green/Green 02` | `#2E994A` | Medium green (light mode success) |
| `Green/Green 03` | `#1C5C2D` | Dark green |

## Red Scale (Negative/Error)

| Token | Hex | Description |
|-------|-----|-------------|
| `Red/Red 01` | `#FCDEDE` | Lightest red (backgrounds) |
| `Red/Red 02` | `#EA2525` | Primary red (error states) |
| `Red/Red 03` | `#7A1313` | Dark red |

## Orange (Warning)

| Token | Hex | Description |
|-------|-----|-------------|
| `Orange/Orange` | `#FFA666` | Warning color |

## Color Mapping

### How Primitives Map to Semantic Tokens

**Dark Mode:**
- Background → `Neutral/Background` (#000000)
- Primary text → `Neutral/Primary` (#FFFFFF)
- Accent → `Rose/Rose 01` (#FFD4D4)
- Success → `Green/Green 02` (#42B852 - adjusted)
- Error → `Red/Red 02` (#EB5842 - adjusted)

**Light Mode:**
- Background → `Neutral/White 00` (#FCFCFC)
- Primary text → `Neutral/Black 07` (#050505)
- Accent → `Rose/Rose 03` (#471414)
- Success → `Green/Green 02` (#2E994A)
- Error → `Red/Red 02` (#EA2525)

## CSS Custom Properties

```css
:root {
  /* Neutral */
  --color-background: #000000;
  --color-primary: #ffffff;
  --color-black-07: #050505;
  --color-grey-06: #292929;
  --color-grey-05: #7a7a7a;
  --color-grey-04: #a8a8a8;
  --color-grey-03: #d1d1d1;
  --color-grey-02: #ebebeb;
  --color-grey-01: #f5f5f5;
  --color-white-00: #fcfcfc;
  
  /* Rose */
  --color-rose-01: #ffd4d4;
  --color-rose-02: #eb8d8d;
  --color-rose-03: #471414;
  
  /* Green */
  --color-green-01: #d9fce2;
  --color-green-02: #2e994a;
  --color-green-03: #1c5c2d;
  
  /* Red */
  --color-red-01: #fcdede;
  --color-red-02: #ea2525;
  --color-red-03: #7a1313;
  
  /* Orange */
  --color-orange: #ffa666;
}
```

## Tailwind Config

```javascript
module.exports = {
  theme: {
    extend: {
      colors: {
        strike: {
          background: '#000000',
          primary: '#ffffff',
          'black-07': '#050505',
          'grey-06': '#292929',
          'grey-05': '#7a7a7a',
          'grey-04': '#a8a8a8',
          'grey-03': '#d1d1d1',
          'grey-02': '#ebebeb',
          'grey-01': '#f5f5f5',
          'white-00': '#fcfcfc',
          'rose-01': '#ffd4d4',
          'rose-02': '#eb8d8d',
          'rose-03': '#471414',
          'green-01': '#d9fce2',
          'green-02': '#2e994a',
          'green-03': '#1c5c2d',
          'red-01': '#fcdede',
          'red-02': '#ea2525',
          'red-03': '#7a1313',
          'orange': '#ffa666',
        }
      }
    }
  }
}
```
