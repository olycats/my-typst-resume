// Import config & components
#import "../config.typ" as project-config
#import "../utils/common.typ" as utils
#import "../utils/document.typ" as document

// Theme configuration
#let default-config = (
  (
    project-config.default-config
  )
    + (
      // Page Setup
      page: (
        margin: (x: 0.8in, y: 0.8in),
        paper: "a4",
      ),
      // Section Titles
      section-titles: (
        summary: "About Me",
        work-experience: "Work Experience",
        education: "Education",
      ),
      // Font Families
      fonts: (
        default: "Carlito",
      ),
      // Font Sizes
      sizes: (
        default: 12pt,
        name: 24pt,
        section-header: 16pt,
        section-line-1: 14pt,
        section-line-2: 12pt,
        summary-paragraph: 14pt,
        meta: 12pt,
      ),
      // Spacing
      spacing: (
        // Vertical spacing between sections
        header-below: 16pt,
        section-title-below: 14pt,
        summary-below: 10pt,
        entries-below: 0pt,
        // Internal spacing within sections
        v-name-to-titles: -8pt,
        v-titles-to-contact: -4pt,
        v-contact-to-line: -2pt,
        v-company-to-position: -6pt,
        v-position-to-highlights: 0pt,
        v-entry-below: 14pt,
        // Paragraph and line spacing
        summary-par-leading: 0.8em,
        highlights-par-leading: 0.4em,
        highlights-row-gutter: 8pt,
        // Summary block inset
        summary-inset: 4pt,
        // Horizontal spacing
        contact-items-spacing: 12pt,
        icon-to-text: 4pt,
        bullet-hanging-indent: 1em,
      ),
    )
)

// Top header - name and titles
#let build-header(data, config) = {
  block(
    width: 100%,
    fill: gradient.linear(
      angle: 45deg,
      config.colors.accent-primary.transparentize(85%),
      config.colors.accent-secondary.transparentize(85%),
    ),
    inset: (y: 28pt),
    radius: 12pt,
    below: config.spacing.header-below,
  )[
    // Name
    #align(center)[
      #text(
        weight: 1200,
        size: config.sizes.name,
        fill: config.colors.accent-primary,
        tracking: 0.8pt,
      )[#data.personal.name]

      #v(config.spacing.v-name-to-titles)

      // Titles
      #text(
        size: config.sizes.section-line-1,
        fill: config.colors.accent-secondary,
        style: "italic",
      )[#data.personal.titles.join(" • ")]
    ]
  ]
}

// Section title
#let build-section-title(section-title, config, icon: none) = {
  block(
    width: 100%,
    below: config.spacing.section-title-below,
  )[

    #grid(
      columns: if icon != none { (auto, auto, 1fr) } else { (auto, 1fr) },
      column-gutter: 8pt,
      align: horizon,

      // Section title icon
      ..if icon != none {
        (
          text(
            size: config.sizes.section-header + 2pt,
            fill: config.colors.accent-primary,
          )[#icon],
        )
      } else { () },

      // Section title text
      text(
        size: config.sizes.section-header,
        weight: 700,
        fill: config.colors.accent-primary,
        tracking: 0.5pt,
      )[#upper(section-title)],

      // Decorative line
      line(
        length: 100%,
        stroke: 1pt + config.colors.border,
      ),
    )
  ]
}


#let build-summary(data, config) = {
  // Return early if summary data is missing
  if ("summary" not in data) or (data.summary == none) {
    return none
  }

  build-section-title(
    config.section-titles.summary,
    config,
    icon: utils.get-icon("summary-section"),
  )

  block(
    width: 100%,
    below: config.spacing.summary-below,
    inset: 10pt,
  )[
    #set par(leading: 0.7em, justify: true)
    #text(
      size: config.sizes.summary-paragraph,
      fill: config.colors.text-body,
    )[#eval(data.summary, mode: "markup")]
  ]
}


#let build-contact-section(data, config) = {
  // Section Title
  build-section-title(
    "Contact",
    config,
    icon: utils.get-icon("contact-section"),
  )

  // Contact list
  for (type, value) in data.personal.contact-items [
    #block(
      width: 100%,
      below: 14pt,
    )[
      #box(width: 10pt)[
        #text(
          size: config.sizes.default,
          fill: config.colors.accent-secondary,
          weight: 600,
        )[#utils.get-icon(type)]
      ]
      #h(6pt)
      #let url = utils.build-contact-url(type, value)
      #text(
        size: config.sizes.default,
        fill: config.colors.text-body,
      )[
        #if url != none [#link(url)[#value]] else [#value]
      ]
    ]
  ]

  // Spacing
  v(20pt)
}

#let build-education(data, config) = {
  // Education section
  build-section-title(
    config.section-titles.education,
    config,
    icon: utils.get-icon("education-section"),
  )

  for edu in data.education [
    #text(
      size: config.sizes.section-line-1,
      weight: 700,
      fill: config.colors.text-entry-line-1,
    )[#edu.line-1]

    #v(-4pt)

    #text(
      size: config.sizes.section-line-2,
      fill: config.colors.text-entry-line-2,
    )[#edu.line-2]

    #v(-4pt)

    #box(width: 14pt)[
      #text(
        fill: config.colors.accent-secondary,
      )[#utils.get-icon("calendar")]
    ]
    #text(
      size: config.sizes.meta,
      fill: config.colors.text-body.lighten(30%),
    )[#utils.build-experience-period(edu)]

    #v(-4pt)

    #box(width: 14pt)[
      #text(
        fill: config.colors.accent-secondary,
      )[#utils.get-icon("location")]
    ]
    #text(
      size: config.sizes.meta,
      fill: config.colors.text-body.lighten(30%),
    )[#edu.location]
  ]
}

// Work Experience with timeline
#let build-work-experience(data, config) = {
  // Section Title
  build-section-title(
    config.section-titles.work-experience,
    config,
    icon: utils.get-icon("work-experience-section"),
  )

  // Entries
  for (idx, work) in data.work.enumerate() [
    #block(
      width: 100%,
      below: config.spacing.v-entry-below,
      breakable: false,
    )[
      #grid(
        columns: (10pt, 1fr),
        column-gutter: 12pt,

        // Timeline dot with line
        [
          #align(center)[
            #box(
              width: 10pt,
              height: 10pt,
              radius: 50%,
              fill: config.colors.accent-secondary,
              stroke: 2.5pt + config.colors.bg-page,
            )
          ]

          // Line extends down (except for last item)
          #if idx < data.work.len() - 1 [
            #place(
              center,
              dy: 5pt,
            )[
              #box(
                width: 2pt,
                height: config.spacing.v-entry-below + 130pt,
                fill: config.colors.border-strong,
              )
            ]
          ]
        ],

        // Content column: period, company, position stacked
        [
          // Period badge
          #box(
            fill: config.colors.accent-secondary.transparentize(95%),
            stroke: 1pt + config.colors.accent-secondary.transparentize(70%),
            inset: (x: 10pt, y: 4pt),
            radius: 10pt,
          )[
            #text(
              size: config.sizes.meta,
              fill: config.colors.accent-secondary,
              weight: 600,
            )[#utils.build-experience-period(work)]
          ]

          #v(-2pt)

          // Add block to indent contents
          #block(inset: (left: 0.8em))[

            // Company and location
            #grid(
              columns: (1fr, auto),
              align: (left, right),

              text(
                size: config.sizes.section-line-1,
                weight: 700,
                fill: config.colors.text-entry-line-1,
              )[#work.line-1],

              text(
                size: config.sizes.meta,
                fill: config.colors.text-body.lighten(30%),
              )[
                #text(fill: config.colors.text-body.lighten(20%))[#utils.get-icon("location")]
                #h(config.spacing.icon-to-text)
                #work.location
              ],
            )

            // Spacing
            #v(config.spacing.v-company-to-position)

            // Position
            #text(
              size: config.sizes.section-line-2,
              fill: config.colors.text-entry-line-2,
            )[#work.line-2]

            #v(config.spacing.v-entry-below)
          ]
        ],
      )
    ]
  ]
}


// Main render
#let render-document(data, config) = {
  show: doc => document.initpage(doc, config)

  // Header with name and titles
  build-header(data, config)

  // About Me (Summary)
  build-summary(data, config)

  // Two-column content: Contact/Education + Work
  grid(
    columns: (35%, 65%),
    column-gutter: 20pt,

    // Left sidebar: Contact + Education
    [
      #build-contact-section(data, config)
      #build-education(data, config)
    ],

    // Right sidebar: Work Experience
    build-work-experience(data, config),
  )
}
