// Import Font Awesome
#import "@preview/fontawesome:0.6.0": *

/// Get icon for location, calendar, and contact type
#let get-icon(type) = {
  let icons = (
    location: fa-location-dot(),
    calendar: fa-calendar-days(),
    email: fa-envelope(),
    linkedin: fa-linkedin(),
    summary-section: fa-user(),
    contact-section: fa-contact-card(),
    education-section: fa-graduation-cap(),
    work-experience-section: fa-briefcase()
  )

  return icons.at(type, default: none)
}

/// Formats the time period string with duration
#let build-experience-period(experience) = {
  if ("duration" in experience) and (experience.duration != none) {
    [
      #experience.start-date - #experience.end-date (#experience.duration)
    ]
  } else {
    [
      #experience.start-date - #experience.end-date
    ]
  }
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
