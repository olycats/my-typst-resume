// Initialize document with basic configs
#let initpage(doc, config, set-footer: false) = {
  // Build footer content if needed
  let footer-content = if set-footer {
    context {
      let page-number = counter(page).get().first()
      let total-pages = counter(page).final().first()

      align(center)[
        #text(
          size: 7.5pt,
          fill: config.colors.text-body.lighten(40%),
        )[
          #h(4pt) - #page-number / #total-pages - #h(4pt)
        ]
      ]
    }
  } else {
    none
  }

  // Apply settings to doc
  set page(
    margin: config.page.margin,
    paper: config.page.paper,
    fill: config.colors.bg-page,
    footer: footer-content,
    footer-descent: if set-footer { 8pt } else { 0pt },
  )

  set text(
    font: config.fonts.default,
    size: config.sizes.default,
    fill: config.colors.text-body,
    ligatures: false, // disabled for ATS friendliness
  )

  doc
}