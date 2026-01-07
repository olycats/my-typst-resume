// Define project level default config
#let default-config = (
  // Page Setup
  page: (
    margin: (x: 0.6in, y: 0.6in),
    paper: "a4",
  ),
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
  // Colors
  colors: (
    // Background Colors
    bg-page: white, // Mandatory for page setup. Other colors are defined in color schemes.
    // Text Colors
    text-body: black, // Mandatory for page setup. Other colors are defined in color schemes.
  ),
)
