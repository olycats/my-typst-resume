// Import modules
#import "../components.typ" as components

// Build entries section (For Work Experience & Education)
#let build(
  experience-data,
  config,
  section-title,
) = {
  block[
    // Section title
    #components.section-title(section-title, config)

    // Work Experience/Education entries
    #for (idx, experience) in experience-data.enumerate() {
      
      // Page break before 3rd entry
      if idx == 2 { 
        // pagebreak() 
        colbreak()
      }

      block(
        width: 100%,
        below: config.spacings.section-gap,
        fill: config.colors.bg-card-entries,
        stroke: 1pt + config.colors.border,
        inset: 18pt,
        radius: 16pt,
      )[
        // Line 1: Company/school -- Location
        #block(
          inset: (left: 12pt),
          stroke: (left: 3pt + rgb("#d4b5a0")),
        )[
          #grid(
            columns: (1fr, auto),
            align: (left, right),
            text(
              size: config.sizes.section-line-1,
              fill: config.colors.text-entry-line-1,
              weight: 500,
            )[
              *#experience.line-1*
            ],
            components.location-badge(experience, config),
          )

          // Line 2: Position/degree -- Date Period
          #grid(
            columns: (1fr, auto),
            align: (left, right),
            text(
              size: config.sizes.section-line-2,
              fill: config.colors.text-entry-line-2,
              weight: 500,
            )[
              #experience.line-2
            ],
            components.experience-period-badge(experience, config),
          )
        ]


        // Highlights
        #if ("highlights" in experience) and (experience.highlights != none) {
          v(-4pt)
          set par(leading: 0.7em)
          for highlight in experience.highlights [
            #block(
              inset: (left: 0pt, top: 0pt, bottom: 0pt),
            )[
              #text(
                fill: config.colors.text-body,
                size: 10pt,
              )[●]
              #h(8pt)
              #text(
                size: config.sizes.default,
                fill: config.colors.text-body,
              )[
                #eval(highlight, mode: "markup")
              ]
            ]
          ]
        }

      ]
    }
  ]
}
