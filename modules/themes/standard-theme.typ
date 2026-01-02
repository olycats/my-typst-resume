// Import config & sections
#import "../core/config.typ" as config
#import "../core/sections/document.typ" as document
#import "../core/sections/header.typ" as header
#import "../core/sections/summary.typ" as summary
#import "../core/sections/entries.typ" as entries

// Theme configuration overriding default layout config
#let default-config = (
  config.default-config
    + (
      // Font Families
      fonts: (
        default: "Carlito",
        heading: "Carlito",
      ),
    )
)

// Render resume
#let render-resume(data, config) = {
  // Document-level show
  show: doc => document.initpage(doc, config)

  // Build header
  header.build(
    data,
    config,
  )

  // Build summary
  summary.build(
    data,
    config,
  )

  // Build work experience entries
  entries.build(
    data.work,
    config,
    config.section-titles.work-experience
  )

  // Build education entries
  entries.build(
    data.education,
    config,
    config.section-titles.education
  )
}

