#import "colors/_default.typ" as color-scheme

// Define project level default config
#let default-config = (
  // Page Setup
  page: (
    margin: (x: 0.6in, y: 0.6in),
    paper: "a4",
  ),
  // Colors
  colors: color-scheme.colors,
  // Section Titles
  section-titles: (
    summary: "Summary",
    work-experience: "Work Experience",
    education: "Education",
  ),
  // Font Families
  fonts: (
    default: "Carlito",
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
  // Spacing
  spacing: (
    // Vertical spacing between sections
    header-below: 6pt,
    section-title-below: 0pt,
    summary-below: 9pt,
    entries-below: 6pt,
    // Internal spacing within sections
    v-name-to-titles: -8pt,
    v-titles-to-contact: -4pt,
    v-contact-to-line: -2pt,
    v-company-to-position: -6pt,
    v-position-to-highlights: -6pt,
    v-highlights-start: -1pt,
    v-entry-below: 10pt,
    // Paragraph and line spacing
    summary-par-leading: 0.8em,
    highlights-par-leading: 0.4em,
    highlights-row-gutter: 8pt,
    // Summary block inset
    summary-inset: 4pt,
    // Horizontal spacing
    contact-items-spacing: 12pt,
    icon-to-text: 4pt,
    bullet-hanging-indent: 1em
  ),
)
