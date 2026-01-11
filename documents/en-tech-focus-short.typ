// Import theme file
#import "../modules/themes/short-theme.typ" as theme
#import "../modules/colors/ubuntu.typ" as color-scheme

// Load YAML data
#let data = yaml("../data/en-tech-focus.yml")

// Override default configuration
#let config = (
  theme.default-config
    // Override default colors
    + (colors: color-scheme.colors)
    // Override additional configs
    + (
      fonts: (
        default: "Carlito",
      ),
    )
)

// Render document
#theme.render-document(data, config)
