// Import theme file
#import "../modules/themes/standard-theme.typ" as theme

// Load YAML data
#let data = yaml("../data/resume-data-zh.yml")

// Define config
#let config = (
  theme.default-config
    + (
      language: "zh-Hant",
      default-font: "Noto Sans CJK TC",
      default-font-size: 10pt,
      heading-1-font-size: 20pt,
      heading-2-font-size: 14pt,
      summary-paragraph-font-size: 12pt,
      section-line-1-font-size: 12pt,
      section-spacing: 1.6em,
      paragraph-leading-spacing: 1.2em,
    )
)

// Render resume
#theme.render-resume(data, config)
