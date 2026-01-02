// Import Font Awesome
#import "@preview/fontawesome:0.6.0": *

/// Formats the location string for an experience entry with location icon
#let build-location(experience) = {
  [#fa-location-dot() #h(2pt) #experience.location]
}

/// Formats the time period string for an experience entry with calendar icon
#let build-experience-period(experience) = {
  let period = [
    #fa-calendar-days() #h(2pt) #experience.start-date - #experience.end-date
  ]

  if ("duration" in experience) and (experience.duration != none) {
    period = [
      #fa-calendar-days() #h(2pt) #experience.start-date - #experience.end-date (#experience.duration)
    ]
  }

  return period
}

/// Get the appropriate icon for a contact type
#let get-contact-icon(type) = {
  let icons = (
    location: fa-location-dot(),
    email: fa-envelope(),
    linkedin: fa-linkedin(),
  )

  return icons.at(type, default: fa-circle-info())
}

/// Build URL for a contact type
#let build-contact-url(type, value) = {
  let url-builders = (
    email: v => "mailto:" + v,
    linkedin: v => "https://" + v,
  )

  // Return none for location
  if type in url-builders {
    return url-builders.at(type)(value)
  } else {
    return none
  }
}

/// Extract contact items from contact data dictionary
#let extract-contact-items(contact-data) = {
  let items = ()

  for (key, value) in contact-data {
    if value != none and value != "" {
      items.push((key, value))
    }
  }

  return items
}

/// Generates a list of contact information items with icons and optional links
#let build-contact-items(contact-data) = {
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
      contact-data.at("location", default: none),
    ),
    contact-item(
      fa-envelope(),
      contact-data.at("email", default: none),
      url: if contact-data.at("email", default: none) != none {
        "mailto:" + contact-data.email
      },
    ),
    contact-item(
      fa-linkedin(),
      contact-data.at("linkedin", default: none),
      url: if contact-data.at("linkedin", default: none) != none {
        "https://" + contact-data.linkedin
      },
    ),
  ).filter(item => item != none)

  return contact-items
}
