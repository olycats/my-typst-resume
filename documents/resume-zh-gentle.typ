// Import theme file
#import "../modules/themes/gentle-theme.typ" as theme
#import "../modules/colors/_default.typ" as color-scheme

// Load YAML data
#let data = yaml("../data/resume-data-zh.yml")

// Override default configuration
#let config = (
  theme.default-config
    // Override default colors
    + (colors: color-scheme.colors)
    // Override additional configs
    + (
      fonts: (
        default: "Noto Sans CJK TC",
      ),
    )
)

// Render document
#theme.render-document(data, config)
