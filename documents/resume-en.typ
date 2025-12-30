// Import layout file
#import "../modules/standard-layout.typ" as layout

// Load YAML data
#let data = yaml("../data/resume-data-en.yml")

// Define config
#let config = (
  layout.default-config
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

// Document-level show
#show: doc => layout.initpage(doc, config)

// Document body
#layout.section-title(data, config)
#layout.section-summary(data, config)
#layout.section-experience(data, config)
#layout.section-education(data, config)
