// Initialize document with basic configs
#let initpage(doc, config) = {
  // Set page margin, paper size, and background color
  set page(
    margin: config.page.margin,
    paper: config.page.paper,
    fill: config.colors.bg-page,
  )

  // Set font family, size, and color
  set text(
    font: config.fonts.default,
    size: config.sizes.default,
    fill: config.colors.text-body,
    ligatures: false, // disabled for ATS friendliness
  )

  // doc starts here
  doc
}
