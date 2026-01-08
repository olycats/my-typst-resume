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
    #text(
      weight: 700,
      size: config.sizes.section-header,
      fill: config.colors.accent-primary,
      tracking: 0.8pt,
    )[#upper(section-title)]
    #v(-8pt)
    #line(
      length: 100%,
      stroke: 1.2pt
        + gradient.linear(
          config.colors.accent-primary,
          config.colors.accent-secondary,
        ),
    )
  ]
}

// Build header
#let build-header(data, config) = {
  block(
    width: 100%,
    below: 6pt,
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

    #v(-8pt)

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
        text(size: config.sizes.meta, fill: config.colors.accent-secondary)[#utils.get-icon(type)]
        h(4pt) // Space between icon and text
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
        spacing: 12pt,
        ..contact-items,
      )
    ]

    #v(-2pt)
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
    below: 12pt,
    inset: 4pt
  )[
    #set par(leading: 0.8em)
    #text(
      size: config.sizes.summary-paragraph,
      fill: config.colors.text-body,
    )[#eval(data.summary, mode: "markup")]
  ]
}

// Work Experience/Education
#let build-entries(work-data, config, section-title) = {
  block[
    #build-section-title(section-title, config)

    #for work in work-data [
      #block(
        width: 100%,
        below: 12pt,
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
          )[#work.line-1],

          // Location
          text(
            size: config.sizes.meta,
            fill: config.colors.text-body.lighten(25%),
          )[
            #utils.get-icon("location") #work.location
          ],
        )
        #v(-6pt)

        // Position & Period
        #grid(
          columns: (auto, 1fr),
          align: (left, right),

          // Position
          text(
            size: config.sizes.section-line-2,
            fill: config.colors.text-entry-line-2,
            style: "italic",
          )[#work.line-2],

          // Location and Date
          text(
            size: config.sizes.meta,
            fill: config.colors.text-body.lighten(25%),
          )[
            #utils.get-icon("calendar") #utils.build-experience-period(work)
          ],
        )
        #v(-6pt)

        // Highlights
        #if ("highlights" in work) and (work.highlights != none) [
          #v(-1pt)
          #set par(leading: 0.4em)
          #grid(
            columns: (100%,),
            row-gutter: 8pt,
            ..work.highlights.map(
              h => text(
                size: config.sizes.default,
                fill: config.colors.text-body,
              )[• #eval(h, mode: "markup")],
            )
          )
        ]
      ]
    ]
    #v(2pt)
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
