// Import config & components
#import "../config.typ" as project-config
#import "../utils/common.typ" as utils
#import "../utils/document.typ" as document

// Theme configuration
#let default-config = (
  project-config.default-config
    + (
      // Font Sizes
      sizes: (
        default: 10pt,
        name: 16pt,
        section-header: 13pt,
        section-line-1: 12pt,
        section-line-2: 10pt,
        summary-paragraph: 11pt,
        meta: 9pt,
      ),
    )
)

// Build section header with underline
#let build-section-title(section-title, config) = {
  block(
    width: 100%,
    below: 10pt,
  )[
    // Section title
    #text(
      weight: 700,
      size: config.sizes.section-header,
      fill: config.colors.accent-primary,
      tracking: 0.8pt,
    )[#upper(section-title)]

    // Spacing between section title and underline
    #v(-8pt)

    // Decorative underline
    #line(
      length: 100%,
      stroke: 1.2pt
        + gradient.linear(
          config.colors.accent-primary,
          config.colors.accent-secondary,
        ),
    )

    // Additional space below
    #v(config.spacing.section-title-below)
  ]
}

// Build header
#let build-header(data, config) = {
  block(
    width: 100%,
    below: config.spacing.header-below,
  )[
    // Name
    #align(center)[
      #text(
        weight: 700,
        size: config.sizes.name,
        fill: config.colors.accent-primary,
        tracking: 0.5pt,
      )[#data.personal.name]
    ]

    #v(config.spacing.v-name-to-titles)

    // Titles
    #align(center)[
      #text(
        fill: config.colors.text-badge-location,
        size: config.sizes.section-line-2,
        style: "italic",
      )[
        #data.personal.titles.join("  •  ")
      ]
    ]

    #v(-4pt)

    // Contact items
    #let contact-items = ()
    #for (type, value) in data.personal.contact-items {
      let icon-and-text = {
        // icon
        text(
          size: config.sizes.meta,
          fill: config.colors.accent-secondary,
        )[#utils.get-icon(type)]
        // spacing between icon and contact text
        h(config.spacing.icon-to-text)
        // Contact text
        text()[#value]
      }

      let url = utils.build-contact-url(type, value)

      if url != none {
        contact-items.push(link(url)[#icon-and-text])
      } else {
        contact-items.push(icon-and-text)
      }
    }
    #align(center)[
      #stack(
        dir: ltr,
        spacing: config.spacing.contact-items-spacing,
        ..contact-items,
      )
    ]

    #v(config.spacing.v-contact-to-line)
    #line(length: 100%, stroke: 0.5pt + config.colors.border)
  ]
}

// Build summary - single line if possible
#let build-summary(data, config) = {
  if ("summary" not in data) or (data.summary == none) {
    return none
  }

  block(
    width: 100%,
    below: config.spacing.summary-below,
    inset: config.spacing.summary-inset,
  )[
    #set par(leading: config.spacing.summary-par-leading)
    #text(
      size: config.sizes.summary-paragraph,
      fill: config.colors.text-body,
    )[#eval(data.summary, mode: "markup")]
  ]
}

// Work Experience/Education
#let build-entries(entries-data, config, section-title) = {
  block[
    #build-section-title(section-title, config)

    #for entry in entries-data [
      #block(
        width: 100%,
        below: config.spacing.v-entry-below,
      )[
        // Company & Location
        #grid(
          columns: (auto, 1fr),
          align: (left, right),

          // Company
          text(
            size: config.sizes.section-line-1,
            fill: config.colors.text-entry-line-1,
            weight: 700,
          )[#entry.line-1],

          // Location
          text(
            size: config.sizes.meta,
            fill: config.colors.text-body.lighten(25%),
          )[
            #utils.get-icon("location") #entry.location
          ],
        )
        #v(config.spacing.v-company-to-position)

        // Position & Period
        #grid(
          columns: (auto, 1fr),
          align: (left, right),

          // Position
          text(
            size: config.sizes.section-line-2,
            fill: config.colors.text-entry-line-2,
            style: "italic",
          )[#entry.line-2],

          // Location and Date
          text(
            size: config.sizes.meta,
            fill: config.colors.text-body.lighten(25%),
          )[
            #utils.get-icon("calendar") #utils.build-experience-period(entry)
          ],
        )
        #v(config.spacing.v-position-to-highlights)

        // Highlights
        #if ("highlights" in entry) and (entry.highlights != none) [
          #v(config.spacing.v-highlights-start)

          #set par(
            leading: config.spacing.highlights-par-leading,
          )

          #grid(
            columns: (100%,),
            row-gutter: config.spacing.highlights-row-gutter,
            ..entry.highlights.map(
              h => block(
                width: 100%,
                inset: (left: config.spacing.bullet-hanging-indent, rest: 0pt),
              )[
                #place(
                  left,
                  dx: -config.spacing.bullet-hanging-indent,
                )[•]
                #text(
                  size: config.sizes.default,
                  fill: config.colors.text-body,
                )[#eval(h, mode: "markup")]
              ],
            )
          )
        ]
      ]
    ]
    #v(config.spacing.entries-below)
  ]
}


// Main render
#let render-document(data, config) = {
  show: doc => document.initpage(doc, config)

  // Header
  build-header(data, config)

  // Summary
  build-summary(data, config)

  // Work Experience
  build-entries(data.work, config, config.section-titles.work-experience)

  // Education
  build-entries(data.education, config, config.section-titles.education)
}
