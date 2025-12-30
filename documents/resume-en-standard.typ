// Import theme file
#import "../modules/themes/standard-theme.typ" as theme

// Load YAML data
#let data = yaml("../data/resume-data-en.yml")

// Define config
#let config = (
  theme.default-config
    + (
      language: "en_US",
      default-font: "Carlito",
      default-font-size: 10pt,
      heading-1-font-size: 20pt,
      heading-2-font-size: 14pt,
      summary-paragraph-font-size: 12pt,
      section-line-1-font-size: 12pt,
      section-spacing: 1.3em,
      paragraph-leading-spacing: 0.5em,
    )
)

// Render resume
#theme.render-resume(data, config)
