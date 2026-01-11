// Import theme file
#import "../modules/themes/compact-theme.typ" as theme
#import "../modules/colors/ubuntu.typ" as color-scheme

// Load YAML data
#let data = yaml("../data/zh-data-focus.yml")

// Override default configuration
#let config = (
  theme.default-config
    // Override default colors
    + (colors: color-scheme.colors)
    // Override additional configs
    + (
      // Font Families
      fonts: (
        default: "Noto Sans CJK TC",
      ), // Font Sizes
      sizes: (
        default: 10pt,
        name: 16pt,
        section-header: 13pt,
        section-line-1: 12pt,
        section-line-2: 10pt,
        summary-paragraph: 11pt,
        meta: 9pt,
      ),
      spacing: (
        // Vertical spacing between sections
        header-below: 6pt,
        section-title-below: 0pt,
        summary-below: 12pt,
        entries-below: 12pt,
        // Internal spacing within sections
        v-name-to-titles: -8pt,
        v-titles-to-contact: -4pt,
        v-contact-to-line: -2pt,
        v-company-to-position: -4pt,
        v-position-to-highlights: -4pt,
        v-highlights-start: 2pt,
        v-entry-below: 12pt,
        // Paragraph and line spacing
        summary-par-leading: 0.8em,
        highlights-par-leading: 0.4em,
        highlights-row-gutter: 8pt,
        // Summary block inset
        summary-inset: 4pt,
        // Horizontal spacing
        contact-items-spacing: 12pt,
        icon-to-text: 4pt,
        bullet-hanging-indent: 1em,
      ),
    )
)

// Render document
#theme.render-document(data, config)
