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
    size: 9pt,
    lang: "en",
    ligatures: false,
  )

  // Paragraph spacing
  set par(leading: 0.5em)

  // Set level 1 heading
  show heading.where(level: 1): it => [
    #set text(
      weight: 700,
      size: 18pt,
      fill: rgb("#c92e62"),
    )
    #pad(it.body)
  ]

  // Set level 2 heading
  show heading.where(level: 2): it => [
    #set text(
      weight: 700,
      size: 12pt,
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
    #text(size: 10pt, fill: rgb("#646060"))[#data.personal.titles.join(` | `)]
    \
    #text(size: 9pt)[#contact-items.join(` | `)]
  ]
}


// Summary Section
#let section-summary(data, config, section-title: "Summary") = {
  if ("summary" in data) and (data.summary != none) {
    block(width: 100%, below: 10pt)[
      == #section-title
      #eval(data.summary, mode: "markup")
    ]
  }
}


// Work Experience Section
#let section-experience(data, config, section-title: "Work Experience", isbreakable: true) = {
  if ("work" in data) and (data.work != none) {
    block[
      == #section-title
      #for work in data.work {
        block(width: 100%, below: 10pt, breakable: isbreakable)[
          // Line 1: Company and Location
          #text(size: 10pt)[*#work.company*]
          #h(1fr)
          #fa-location-dot() #work.location
          #v(-3pt)

          // Line 2: Position and Date Range
          #text(size: 9pt)[#work.position]
          #h(1fr)
          #text(style: "italic", size: 8pt, fill: rgb("#646060"))[
            #work.startdate - #work.enddate (#work.duration)
          ]
          #v(-3pt)

          // Highlights
          #for highlight in work.highlights [
            - #eval(highlight, mode: "markup")
          ]
        ]
      }
    ]
  }
}

// Education Section
#let section-education(data, config, section-title: "Education", isbreakable: true) = {
  if ("education" in data) and (data.education != none) {
    block[
      == #section-title
      #for education in data.education {
        // Create a block layout for each education entry
        block(width: 100%, below: 8pt, breakable: isbreakable)[

          // Line 1: School and Location
          #text(size: 10pt)[*#education.school*]
          #h(1fr)
          #text(size: 8pt)[#fa-location-dot() #education.location]
          #v(-3pt)

          // Line 2: Degree and Date
          #text(size: 9pt)[#education.description]
          #h(1fr)
          #text(style: "italic", size: 8pt, fill: rgb("#646060"))[
            #education.startdate - #education.enddate
          ]
        ]
      }
    ]
  }
}
