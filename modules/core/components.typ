// Import modules
#import "utils.typ" as utils
#import "shapes.typ" as shapes

// Section title component
#let section-title(section-title, config) = {
  // Title text
  text(
    weight: 700,
    size: config.sizes.section-header,
    fill: config.colors.text-section-title,
  )[
    #section-title
  ]

  // Decorative underline
  box(
    width: 100%,
    height: 3pt,
    fill: gradient.linear(
      config.colors.gradient-start,
      config.colors.gradient-middle,
      config.colors.gradient-end,
    ),
    radius: 1.5pt,
  )
}

// Titles badge
#let titles-badge(config, titles) = {
  let formatted-text = titles.join("  •  ")

  shapes.badge(
    content: formatted-text,
    inset: (x: 10pt, y: 5pt),
    radius: 12pt,
    bg: config.colors.bg-badge-1,
    fg: config.colors.text-badge-1,
    border: 1pt + rgb("#e8d5c4"),
    text-size: 9.5pt,
  )
}

// Contact item badge
#let contact-badges(
  config,
  contact-items,
) = {
  let badges = ()

  for (type, value) in contact-items {
    let icon = utils.get-contact-icon(type)
    let url = utils.build-contact-url(type, value)

    let badge = shapes.badge(
      content: value,
      icon: icon,
      url: url,
      inset: (x: 10pt, y: 5pt),
      radius: 12pt,
      bg: config.colors.bg-badge-1,
      fg: config.colors.text-badge-1,
      text-size: 9.5pt,
    )

    if badge != none {
      badges = badges + (badge,)
    }
  }

  // Render badges in a horizontal stack
  stack(
    dir: ltr,
    spacing: 8pt,
    ..badges,
  )
}

/// Location badge for an experience entry
#let location-badge(experience, config) = {
  shapes.badge(
    content: utils.build-location(experience),
    inset: (x: 10pt, y: 5pt),
    radius: 12pt,
    bg: config.colors.bg-badge-1,
    fg: config.colors.text-badge-1,
    text-size: 9.5pt,
  )
}

/// Period badge for an experience entry
#let experience-period-badge(experience, config) = {
  shapes.badge(
    content: utils.build-experience-period(experience),
    inset: (x: 10pt, y: 5pt),
    radius: 12pt,
    bg: config.colors.bg-badge-2,
    fg: config.colors.text-badge-2,
    text-size: 9.5pt,
  )
}

