// Define project level default config
#let default-config = (
  // Section Titles
  section-titles: (
    summary: "Summary",
    work-experience: "Work Experience",
    education: "Education",
  ),
  // Font Families
  fonts: (
    default: "Carlito",
    heading: "Carlito",
  ),
  // Font Sizes
  sizes: (
    default: 11pt,
    name: 20pt,
    section-header: 16pt,
    section-line-1: 14pt,
    section-line-2: 12pt,
    summary-paragraph: 12pt,
    meta: 9pt,
  ),
  // Spacings
  spacings: (
    leading: 0.5em,
    section-gap: 1.3em,
    card-gap: 12pt,
    item-gap: 8pt,
  ),
  // Radius
  radius: (
    card: 20pt,
    badge: 12pt,
    icon: 6pt,
  ),
  // borders
  borders: (
    card: 2pt,
    badge: 1pt,
  ),
  // Page Setup
  page: (
    margin: (x: 0.6in, y: 0.6in),
    paper: "a4",
  ),
  // Colors
  colors: (
    // === Background Colors ===
    bg-page: rgb("#faf7f2"), // Soft beige
    bg-card-header: white, // Pure white
    bg-card-summary: rgb("#f9f3ed"), // Warm cream
    bg-card-entries: white, // Pure white
    bg-badge-1: rgb("#fff9f0"), // Warm taupe
    bg-badge-2: rgb("#f5ede4"), // Deeper taupe
    // === Text Colors ===
    text-body: rgb("#4a3d32"), // Darker brown
    text-name: rgb("#5a4838"), // Rich brown
    text-section-title: rgb("#6b5744"), // Warm brown
    text-entry-line-1: rgb("#5a4838"), // Company/School - same as name
    text-entry-line-2: rgb("#7a6555"), // Position/Degree - lighter (hierarchy)
    text-badge-1: rgb("#8b6f47"), // Date badge
    text-badge-2: rgb("#8b7565"), // Location badge
    // === Border Colors ===
    border: rgb("#e8dfd4"), // Warmer border
    border-light: rgb("#f0e8de"), // Very light border
    border-strong: rgb("#d4c5b5"), // Strong border
    border-accent: rgb("#c4b5a5"), // Accent border
    // === Decorative Colors ===
    // Primary gradient (for section dividers)
    gradient-start: rgb("#d4c5b5").transparentize(20%),
    gradient-middle: rgb("#c4b5a5").transparentize(40%),
    gradient-end: rgb("#e8dfd4").transparentize(70%),
    // Secondary gradient (for backgrounds)
    gradient-bg-start: rgb("#fdfbf8"),
    gradient-bg-end: rgb("#f9f3ed"),
  ),
)
