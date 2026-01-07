// Import theme file
#import "../modules/themes/gentle-theme.typ" as theme

// Load YAML data
#let data = yaml("../data/resume-data-en.yml")

// Override default configuration
#let config = (
  theme.default-config
    + (
      // Font Families
      fonts: (
        default: "Carlito",
      ),
    )
)

// Render document
#theme.render-document(data, config)
