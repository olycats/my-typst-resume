// Import theme file
#import "../modules/themes/standard-theme.typ" as theme

// Load YAML data
#let data = yaml("../data/resume-data-en.yml")

// Override default configuration
#let config = (
  theme.default-config
    + (
      // Font Families
      fonts: (
        default: "Carlito",
        heading: "Carlito",
      ),
    )
)

// Render resume
#theme.render-resume(data, config)
