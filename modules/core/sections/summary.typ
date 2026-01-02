// Import modules
#import "../components.typ" as components

// Build summary section
#let build(
  data,
  config,
  section-title: "Summary",
) = {
  if ("summary" in data) and (data.summary != none) {
    block(
      width: 100%,
      below: config.spacings.section-gap,
    )[
      // Section title
      #components.section-title(section-title, config)

      // Summary content
      #v(-10pt) // Reduce space after title
      #block(
        width: 100%,
        fill: config.colors.bg-card-summary,
        inset: 16pt,
        radius: 6pt,
      )[
        #text(
          size: config.sizes.summary-paragraph,
        )[
          #eval(data.summary, mode: "markup")
        ]
      ]
    ]
  }
}
