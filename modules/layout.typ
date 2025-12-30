#import "@preview/fontawesome:0.6.0": *

#let initpage(doc, config) = {
  // Set page
  set page(
    margin: (x: 0.4in, y: 0.4in),
    paper: "a4",
    fill: rgb("#ffffff"),
  )

  // Set font
  set text(
    font: config.default-font,
    size: eval(config.default-font-size),
    ligatures: false,
  )

  // Paragraph spacing
  set par(leading: eval(config.paragraph-leading-spacing))

  // Set level 1 heading
  show heading.where(level: 1): it => [
    #set text(
      weight: 700,
      size: eval(config.heading-1-font-size),
      fill: rgb("#c92e62"),
    )
    #pad(it.body)
  ]

  // Set level 2 heading
  show heading.where(level: 2): it => [
    #set text(
      weight: 700,
      size: eval(config.heading-2-font-size),
      fill: rgb("#c92e62"),
    )
    #pad(top: 0pt, bottom: -10pt, [#smallcaps(it.body)])
    #line(length: 100%, stroke: 0.8pt)
  ]

  // doc starts here
  doc
}

// Title Section
#let section-title(data, config) = {
  let contact = data.personal.contactitems

  // Helper function to create contact information items
  let contact-item(icon, content, url: none) = {
    if content == none or content == "" {
      return none
    }

    if url != none {
      link(url)[#icon #content]
    } else {
      [#icon #content]
    }
  }

  // Collect all valid contact items
  let contact-items = (
    contact-item(
      fa-location-dot(),
      contact.at("location", default: none),
    ),
    contact-item(
      fa-envelope(),
      contact.at("email", default: none),
      url: if contact.at("email", default: none) != none {
        "mailto:" + contact.email
      },
    ),
    contact-item(
      fa-linkedin(),
      contact.at("linkedin", default: none),
      url: if contact.at("linkedin", default: none) != none {
        "https://" + contact.linkedin
      },
    ),
  ).filter(item => item != none)

  // Render title with name, desired titles, and contact information
  align(center)[
    = #data.personal.name
    #text(size: eval(config.default-font-size), fill: rgb("#646060"))[#data.personal.titles.join(` | `)]
    \
    #text(size: eval(config.default-font-size))[#contact-items.join(` | `)]
  ]
}


// Summary Section
#let section-summary(data, config, section-title: "Summary") = {
  if ("summary" in data) and (data.summary != none) {
    block(width: 100%, below: eval(config.section-spacing))[
      == #section-title
      #text(size: eval(config.summary-paragraph-font-size))[
        #eval(data.summary, mode: "markup")
      ]
      
    ]
  }
}

// Experience period string
#let experience-period-string(experience, config) = {
  if ("duration" in experience) and (experience.duration != none) {
    text(style: "italic", size: eval(config.default-font-size), fill: rgb("#646060"))[
      #fa-calendar-days() #experience.startdate - #experience.enddate (#experience.duration)
    ]
    v(-3pt)
  } else {
    text(style: "italic", size: eval(config.default-font-size), fill: rgb("#646060"))[
      #fa-calendar-days() #experience.startdate - #experience.enddate
    ]
    v(-3pt)
  }
}

// Experience Section (shared function for Work Experience & Education)
#let experience-section(section-title, experience-data, config) = {
  block[
    == #section-title
    #for experience in experience-data {
      block(width: 100%, below: eval(config.section-spacing))[
        // Line 1: Company/school -- Location
        #text(size: eval(config.section-line-1-font-size))[*#experience.line-1*]
        #h(1fr)
        #fa-location-dot() #experience.location
        #v(-3pt)

        // Line 2: Position/degree -- Date Period
        #text(size: eval(config.default-font-size))[#experience.line-2]
        #h(1fr)
        #experience-period-string(experience, config)

        // Highlights
        #if ("highlights" in experience) and (experience.highlights != none) {
          for highlight in experience.highlights [
            - #eval(highlight, mode: "markup")
          ]
        }
      ]
    }
  ]
}

// Work Experience Section
#let section-experience(data, config) = {
  if ("work" in data) and (data.work != none) {
    experience-section("Work Experience", data.work, config)
  }
}

// Education Section
#let section-education(data, config, section-title: "Education") = {
  if ("education" in data) and (data.education != none) {
    experience-section("Education", data.education, config)
  }
}
