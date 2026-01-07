// Import config & components
#import "../config.typ" as project-config
#import "../utils/common.typ" as utils
#import "../utils/document.typ" as document

// Theme configuration - Sharp version (修正版)
#let default-config = (
  project-config.default-config
    + (
      fonts: (
        default: "Carlito",
      ),
    )
    + (
      colors: (
        // Background
        bg-page: rgb("#ffffff"),
        bg-card-header: rgb("#f8f9fa"),
        bg-card-summary: rgb("#f1f3f5"),
        bg-card-entries: white,
        bg-badge-date: rgb("#e2e8f0"),
        bg-badge-location: rgb("#e2e8f0"),
        bg-badge-contact: rgb("#e2e8f0"),
        // Text
        text-body: rgb("#1e293b"),
        text-name: rgb("#0f172a"),
        text-section-title: rgb("#334155"),
        text-entry-line-1: rgb("#0f172a"),
        text-entry-line-2: rgb("#475569"),
        text-badge-date: rgb("#1e293b"),
        text-badge-location: rgb("#475569"),
        text-badge-contact: rgb("#64748b"),
        // Borders
        border: rgb("#e2e8f0"),
        border-strong: rgb("#cbd5e1"),
        // Accents
        accent-primary: rgb("#0f172a"),
        accent-secondary: rgb("#64748b"),
      ),
    )
)

// Section Title
#let build-section-title(section-title, config) = {
  block(
    width: 100%,
    below: 8pt,
  )[
    #grid(
      columns: (auto, 1fr),
      column-gutter: 12pt,
      align: horizon,

      box(
        width: 4pt,
        height: 18pt,
        fill: config.colors.accent-primary,
        radius: 0pt,
      ),

      text(
        weight: 700,
        size: config.sizes.section-header,
        fill: config.colors.text-section-title,
        tracking: 1pt,
      )[#upper(section-title)],
    )
  ]
}

// Header components
#let build-header-name(data, config) = {
  align(center)[
    #text(
      weight: 800,
      size: config.sizes.name,
      fill: config.colors.text-name,
      tracking: 0pt,
    )[#upper(data.personal.name)]
  ]
}

#let build-header-titles(data, config) = {
  align(center)[
    #text(
      fill: config.colors.text-section-title,
      size: config.sizes.section-line-2,
      weight: 500,
    )[
      #data.personal.titles.join("  |  ")
    ]
  ]
}

#let build-header-contact-list(data, config) = {
  align(center)[
    #let items = ()

    #for (type, value) in data.personal.contact-items {
      let icon-and-text = {
        text(
          size: config.sizes.meta,
          fill: config.colors.accent-secondary,
        )[#utils.get-icon(type)]
        h(4pt)
        text(
          size: 9.5pt,
          fill: config.colors.text-badge-contact,
        )[#value]
      }

      let content-with-url = {
        let url = utils.build-contact-url(type, value)
        if url != none {
          link(url)[#icon-and-text]
        } else {
          icon-and-text
        }
      }

      items = items + (content-with-url,)
    }

    #text(fill: config.colors.text-badge-contact)[
      #items.join([  #text(fill: config.colors.border-strong)[|]  ])
    ]
  ]
}

#let build-header(data, config) = {
  block(
    width: 100%,
    fill: config.colors.bg-card-header,
    inset: (x: 20pt, y: 18pt),
    radius: 0pt,
    below: 16pt,
  )[
    #build-header-name(data, config)

    #v(8pt)
    #align(center)[
      #line(length: 40%, stroke: 2pt + config.colors.accent-primary)
    ]
    #v(8pt)

    #build-header-titles(data, config)
    #v(10pt)
    #build-header-contact-list(data, config)
  ]
}

// Summary - 修正排版問題 ✅
#let build-summary(data, config) = {
  if ("summary" not in data) or (data.summary == none) {
    return none
  }

  block(
    width: 100%,
    below: 1.2em,
  )[
    #build-section-title(config.section-titles.summary, config)

    #v(6pt)

    #block(
      width: 100%,
      fill: config.colors.bg-card-summary,
      inset: (left: 20pt, right: 16pt, top: 14pt, bottom: 14pt), // 左側多一點
      radius: 4pt,
      stroke: 1pt + config.colors.border,
    )[
      #set par(first-line-indent: 1.5em)  // 首行縮排
      #text(
        size: config.sizes.summary-paragraph,
        fill: config.colors.text-body,
        weight: 400,
      )[#eval(data.summary, mode: "markup")]
    ]
  ]
}



// Entries - 修正 Date badge ✅
#let build-entries(
  experience-data,
  config,
  section-title,
  show-highlights: true,
  page-break-after: 99,
) = {
  block[
    #build-section-title(section-title, config)

    #v(6pt)

    #for (idx, experience) in experience-data.enumerate() {
      if idx == page-break-after {
        colbreak()
      }

      block(
        width: 100%,
        below: 1.2em,
        fill: config.colors.bg-card-entries,
        stroke: 1.5pt + config.colors.border,
        inset: (x: 16pt, y: 14pt),
        radius: 4pt,
      )[
        // Company/School 和 Location
        #grid(
          columns: (1fr, auto),
          align: (left, right + horizon),

          text(
            size: config.sizes.section-line-1,
            fill: config.colors.text-entry-line-1,
            weight: 700,
          )[#experience.line-1],

          box(
            inset: (x: 8pt, y: 4pt),
            radius: 4pt,
            fill: config.colors.bg-badge-location,
          )[
            #text(
              size: config.sizes.meta,
              fill: config.colors.text-badge-location,
              weight: 500,
            )[
              #utils.get-icon("location")
              #h(3pt)
              #experience.location
            ]
          ],
        )

        #v(-2pt)

        // Position 和 Date
        #grid(
          columns: (1fr, auto),
          align: (left, right),

          text(
            size: config.sizes.section-line-2,
            fill: config.colors.text-entry-line-2,
            weight: 500,
          )[#experience.line-2],

          // Date badge - 淺底深字 ✅
          box(
            inset: (x: 8pt, y: 4pt),
            radius: 4pt,
            fill: config.colors.bg-badge-date,
            stroke: 1pt + config.colors.border-strong, // 加邊框增強視覺
          )[
            #text(
              size: config.sizes.meta,
              fill: config.colors.text-badge-date,
              weight: 600,
            )[
              #utils.get-icon("calendar")
              #h(3pt)
              #utils.build-experience-period(experience)
            ]
          ],
        )

        #v(2pt)

        #if (
          not show-highlights or ("highlights" not in experience) or (experience.highlights == none)
        ) {
          continue
        }

        #set par(leading: 0.55em)

        // 方形子彈點
        #for highlight in experience.highlights [
          #block(above: 4pt)[
            #box(
              width: 3pt,
              height: 3pt,
              fill: config.colors.accent-primary,
              radius: 0pt,
            )
            #h(8pt)
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
  show: doc => document.initpage(doc, config)
  build-header(data, config)
  build-summary(data, config)
  build-entries(
    data.work,
    config,
    config.section-titles.work-experience,
    show-highlights: true,
    page-break-after: 2,
  )
  build-entries(
    data.education,
    config,
    config.section-titles.education,
  )
}
