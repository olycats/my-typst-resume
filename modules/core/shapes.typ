// Badge
#let badge(
  content: "",
  icon: none,
  url: none,
  inset: (x: 10pt, y: 5pt),
  radius: 12pt,
  bg: none,
  fg: black,
  border: none,
  text-size: 9.5pt,
) = {
  let icon-and-text = {
    text(
      fill: fg,
      size: text-size,
    )[
      #icon
    ]
    h(4pt) // Space between icon and text
    text(
      size: text-size,
      fill: fg,
      weight: 500,
    )[
      #content
    ]
  }

  // Format content with or without link
  let formatted-text = {
    if url != none {
      link(url)[
        #icon-and-text
      ]
    } else {
      icon-and-text
    }
  }

  // Render box
  box(
    inset: inset,
    radius: radius,
    fill: bg,
    stroke: border,
    text(fill: fg)[
      #formatted-text
    ],
  )
}
