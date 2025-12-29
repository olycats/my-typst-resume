// Import layout.typ file
#import "../modules/layout.typ"

// Load YAML data
#let data = yaml("../data/resume-data-en.yml")
#let config = yaml("../data/config-en.yml")

// Document-level show
#show: doc => layout.initpage(doc, config)

// Document body
#layout.section-title(data, config)
#layout.section-summary(data, config)
#layout.section-experience(data, config)
#layout.section-education(data, config)