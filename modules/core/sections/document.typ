// Initialize page layout
#let initpage(doc, config) = {
  // Set page
  set page(
    margin: config.page.margin,
    paper: config.page.paper,
    fill: config.colors.bg-page,
  )

  // Set font
  set text(
    font: config.fonts.default,
    size: config.sizes.default,
    ligatures: false,
  )

  // Set paragraph spacing
  set par(leading: config.spacings.leading)

  // doc starts here
  doc
}

