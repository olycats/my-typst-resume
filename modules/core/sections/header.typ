// Import modules
#import "../components.typ" as components

// Build Header (Name, Titles, Contact Info)
#let build(
  data,
  config,
) = {
  // Prepare name content
  let name-content = (
    text(
      weight: 700,
      size: config.sizes.name,
      fill: config.colors.text-name,
    )[
      #data.personal.name
    ]
  )

  // Prepare titles content
  let titles-content = (
    components.titles-badge(
      config,
      data.personal.titles,
    )
  )

  // Prepare contact items content
  let contact-items-content = {
    components.contact-badges(
      config,
      data.personal.contact-items,
    )
  }

  // Render outer block with contents
  block(
    width: 100%,
    fill: config.colors.bg-card-header,
    inset: 24pt,
    radius: 24pt,
    below: 22pt,
    outset: 0pt,
  )[
    #align(center)[#name-content]
    #align(center)[#titles-content]
    #v(8pt)
    #align(center)[#contact-items-content]
  ]
}
