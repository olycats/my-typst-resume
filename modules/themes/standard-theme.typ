// Import config & components
#import "../config.typ" as project-config
#import "../utils/common.typ" as utils
#import "../utils/document.typ" as document

// Theme configuration
#let default-config = (
  project-config.default-config
    // Override default config values
    + (
      // Font Families
      fonts: (
        default: "Carlito",
      ),
    )
    // Add theme-specific config
    + (
      // Colors
      colors: (
        // Background colors
        bg-page: rgb("#faf7f2"), // Soft beige
        bg-card-header: white,
        bg-card-summary: rgb("#f9f3ed"), // Warm cream
        bg-card-entries: white, // Pure white
        bg-badge-date: rgb("#e8dfd4"), // Warm gray-beige
        bg-badge-location: rgb("#f5ede4"), // Light beige
        bg-badge-contact: rgb("#f9f3ed"), // Soft cream
        // Text colors
        text-body: rgb("#4a3d32"), // Darker brown
        text-name: rgb("#5a4838"), // Rich brown
        text-section-title: rgb("#6b5744"), // Warm brown
        text-entry-line-1: rgb("#5a4838"), // Company/School
        text-entry-line-2: rgb("#7a6555"), // Position/Degree
        text-badge-date: rgb("#6b5744"), // Medium brown
        text-badge-location: rgb("#8b7565"), // Light brown
        text-badge-contact: rgb("#7a6555"), // Warm brown
        // Borders
        border: rgb("#e8dfd4"), // Warmer border
        // Deco
        gradient-start: rgb("#d4c5b5").transparentize(20%),
        gradient-middle: rgb("#c4b5a5").transparentize(40%),
        gradient-end: rgb("#e8dfd4").transparentize(70%),
        // Accent colors
        accent-primary: rgb("#8b6f47"),
        accent-secondary: rgb("#a0826d"),
      ),
    )
)

// Build section title
#let build-section-title(section-title, config) = {
  block(
    width: 100%,
    below: 10pt,
  )[
    // Title text
    #v(4pt)
    #text(
      weight: 700,
      size: config.sizes.section-header,
      fill: config.colors.text-section-title,
      tracking: 0.5pt
    )[#upper(section-title)]

    // Adjust spacing
    #v(-10pt)

    // Decorative underline
    #box(
      width: 100%,
      height: 2.5pt,
      fill: gradient.linear(
        config.colors.gradient-start,
        config.colors.gradient-middle,
        config.colors.gradient-end,
      ),
      radius: 1.5pt,
    )
  ]
}

// Build name in header
#let build-header-name(data, config) = {
  align(center)[
    #text(
      weight: 700,
      size: config.sizes.name,
      fill: config.colors.text-name,
      tracking: 0.5pt,
    )[#data.personal.name]
  ]
}

// Build decorative underline in header
#let build-header-underline(config) = {
  // Elegant underline
  align(center)[
    #box(
      width: 45%,
      height: 2.5pt,
      radius: 1.5pt,
      fill: gradient.linear(
        config.colors.gradient-start.transparentize(50%),
        config.colors.accent-primary,
        config.colors.gradient-end.transparentize(50%),
      ),
    )
  ]
}

// Titles in header
#let build-header-titles(data, config) = {
  align(center)[
    #text(
      fill: config.colors.text-section-title,
      size: config.sizes.section-line-2,
      style: "italic"
    )[
      #data.personal.titles.join("  •  ")
    ]

  ]
}

// Contact list in header
#let build-header-contact-list(data, config) = {
  align(center)[
    #let badges = ()

    #for (type, value) in data.personal.contact-items {
      let icon-and-text = {
        text(size: config.sizes.meta)[#utils.get-icon(type)]
        h(4pt) // Space between icon and text
        text()[#value]
      }

      let content-with-url = {
        let url = utils.build-contact-url(type, value)

        if url != none {
          link(url)[
            #icon-and-text
          ]
        } else {
          icon-and-text
        }
      }

      let badge = box(
        inset: (x: 10pt, y: 5pt),
        radius: 12pt,
        fill: config.colors.bg-badge-contact,
        text(
          fill: config.colors.text-badge-contact,
        )[
          #content-with-url
        ],
      )

      if badge != none {
        badges = badges + (badge,)
      }
    }

    // Render badges in a horizontal stack
    #stack(
      dir: ltr,
      spacing: 8pt,
      ..badges,
    )
  ]
}

// Build header block
#let build-header(data, config) = {
  block(
    width: 100%,
    fill: config.colors.bg-card-header,
    inset: 16pt,
    radius: 20pt,
    below: 18pt,
    outset: 0pt,
  )[
    #build-header-underline(config)
    #v(-6pt)
    #build-header-name(data, config)
    #v(2pt)
    #build-header-titles(data, config)
    #v(6pt)
    #build-header-contact-list(data, config)
  ]
}

// Build summary section with styled content block
#let build-summary(data, config) = {
  // Return early if summary data is missing
  if ("summary" not in data) or (data.summary == none) {
    return none
  }

  block(
    width: 100%,
    below: 1.3em,
  )[
    #build-section-title(config.section-titles.summary, config)

    #v(4pt) // Fine-tune spacing

    #block(
      width: 100%,
      fill: config.colors.bg-card-summary,
      stroke: (left: 4pt + config.colors.accent-secondary),
      inset: 16pt,
      radius: 6pt,
    )[
      // Opening quote mark
      #place(
        top + left,
        dx: -8pt,
        dy: -8pt,
        text(
          size: 36pt,
          fill: config.colors.accent-primary.transparentize(75%),
          weight: 700,
        )["],
      )

      // Adjust spacing
      #v(10pt)

      // Paragraph
      #text(
        size: config.sizes.summary-paragraph,
      )[#eval(data.summary, mode: "markup")]

      // Small decorative element at the end
      #v(-2pt)
      #align(right)[
        #box(
          width: 15%,
          height: 2pt,
          radius: 1pt,
          fill: gradient.linear(
            config.colors.accent-secondary.transparentize(60%),
            config.colors.accent-primary.transparentize(20%),
          ),
        )
      ]
      #v(-10pt)

    ]
  ]
}

// Build work experience / education entries
#let build-entries(
  experience-data,
  config,
  section-title,
  show-highlights: true,
  page-break-after: 99,
) = {
  block[
    #build-section-title(section-title, config)

    #for (idx, experience) in experience-data.enumerate() {
      // Force page break after designated entry
      if idx == page-break-after {
        colbreak()
      }

      // Styled card for each experience entry
      block(
        width: 100%,
        below: 1.3em,
        fill: config.colors.bg-card-entries,
        stroke: 1pt + config.colors.border,
        inset: 16pt,
        radius: 16pt,
      )[

        // Line 1: Company/school -- Location
        #grid(
          columns: (1fr, auto),
          align: (left, right),
          // Left: Company/School
          {
            v(0.7em) // Adjust vertical alignment
            text(
              size: config.sizes.section-line-1,
              fill: config.colors.text-entry-line-1,
              weight: 600,
            )[#experience.line-1]
          },

          // Right: Location Badge
          // components.location-badge(experience, config),
          box(
            inset: (x: 10pt, y: 5pt),
            radius: 10pt,
            fill: config.colors.bg-badge-location,
            text(
              size: config.sizes.meta,
              fill: config.colors.text-badge-location,
            )[
              #utils.get-icon("location")
              #h(2pt)
              #experience.location
            ],
          ),
        )

        // Adjust spacing between line-1 and line-2
        #v(-4pt)

        // Line 2: Position/degree -- Date Period
        #grid(
          columns: (1fr, auto),
          align: (left, right),
          // Left: Position/degree
          text(
            size: config.sizes.section-line-2,
            fill: config.colors.text-entry-line-2,
            weight: 500,
            style: "italic"
          )[#experience.line-2],

          // Right: Date Period
          box(
            inset: (x: 10pt, y: 5pt),
            radius: 10pt,
            fill: config.colors.bg-badge-date,
            text(
              size: config.sizes.meta,
              fill: config.colors.text-badge-date,
            )[
              #utils.get-icon("calendar")
              #h(2pt)
              #utils.build-experience-period(experience)
            ],
          ),
        )

        // Adjust spacing between entry title and highlights
        #v(-2pt)

        // Continue for if highlights are disabled
        #if (
          not show-highlights or ("highlights" not in experience) or (experience.highlights == none)
        ) {
          continue
        }

        // Adjust spacing between highlights lines
        #set par(leading: 0.5em)

        // Highlights lines
        #for highlight in experience.highlights [
          #block()[
            #box(
              width: 4pt,
              height: 4pt,
              fill: config.colors.accent-primary,
              radius: 50%,
            )
            #h(8pt) // Spacing between bullet and text
            #text(
              size: config.sizes.default,
              fill: config.colors.text-body,
            )[#eval(highlight, mode: "markup")]
          ]
        ]
      ]
    }
  ]
}

// Render document
#let render-document(data, config) = {
  // Document-level show
  show: doc => document.initpage(doc, config)

  // Build header
  build-header(
    data,
    config,
  )

  // Build summary
  build-summary(
    data,
    config,
  )

  // Build work experience entries
  build-entries(
    data.work,
    config,
    config.section-titles.work-experience,
    show-highlights: true,
    page-break-after: 2,
  )

  // Build education entries
  build-entries(
    data.education,
    config,
    config.section-titles.education,
  )
}

