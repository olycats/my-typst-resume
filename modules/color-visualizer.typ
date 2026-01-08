// Import all color schemes
#import "./colors/_default.typ" as default
#import "./colors/ubuntu.typ" as ubuntu
#import "./colors/ruby.typ" as ruby
#import "./colors/mustard.typ" as mustard
#import "./colors/amber.typ" as amber
#import "./colors/olive.typ" as olive
#import "./colors/mint.typ" as mint
#import "./colors/forest.typ" as forest
#import "./colors/ocean.typ" as ocean
#import "./colors/sky.typ" as sky
#import "./colors/cyan.typ" as cyan
#import "./colors/grape.typ" as grape
#import "./colors/espresso.typ" as espresso
#import "./colors/terracotta.typ" as terracotta
#import "./colors/coral.typ" as coral

// ============================================
// Define Scheme list
// ============================================
#let schemes = (
  ("Default", default),
  ("Ubuntu", ubuntu),
  ("Ruby", ruby),
  ("Mustard", mustard),
  ("Amber", amber),
  ("Olive", olive),
  ("Forest", forest),
  ("Mint", mint),
  ("Ocean", ocean),
  ("Sky", sky),
  ("Cyan", cyan),
  ("Grape", grape),
  ("Espresso", espresso),
  ("Terracotta", terracotta),
  ("Coral", coral),
)

// ============================================
// Page setup
// ============================================
#set page(
  paper: "a4",
  margin: (x: 1in, y: 1in),
)

#set text(
  font: "Carlito",
  size: 10pt,
)

#set text(
  font: "Carlito",
  size: 10pt,
)

// ============================================
// Title
// ============================================
#align(center)[
  #text(size: 20pt, weight: 700)[
    Color Scheme Comparison
  ]
]

#v(20pt)

// ============================================
// Helper function to display a color scheme preview
// ============================================
#let display-scheme(name, scheme) = {
  let c = scheme.colors
  
  block(
    width: 100%,
    fill: c.bg-page,
    stroke: 1pt + rgb("#ddd"),
    inset: 16pt,
    radius: 8pt,
    breakable: false,
  )[
    // Scheme name
    #text(size: 14pt, weight: 700, fill: c.accent-primary)[
      #name
    ]
    
    #v(8pt)
    
    // Color swatches in grid
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 8pt,
      
      // Row 1: Accents (most important)
      block(
        width: 100%,
        height: 40pt,
        fill: c.accent-primary,
        radius: 4pt,
      )[
        #align(center + horizon)[
          #text(fill: white, size: 8pt, weight: 600)[PRIMARY]
        ]
      ],
      
      block(
        width: 100%,
        height: 40pt,
        fill: c.accent-secondary,
        radius: 4pt,
      )[
        #align(center + horizon)[
          #text(fill: white, size: 8pt, weight: 600)[SECONDARY]
        ]
      ],
      
      block(
        width: 100%,
        height: 40pt,
        fill: c.text-name,
        radius: 4pt,
      )[
        #align(center + horizon)[
          #text(fill: white, size: 8pt, weight: 600)[NAME]
        ]
      ],
      
    )
    
    #v(6pt)
    
    // Preview samples
    #grid(
      columns: (1fr, 1fr),
      gutter: 10pt,
      
      // Left: Header preview
      block(
        width: 100%,
        fill: c.bg-card-header,
        inset: 12pt,
        radius: 6pt,
        stroke: 1pt + c.border,
      )[
        #align(center)[
          #box(
            width: 60%,
            height: 2pt,
            fill: gradient.linear(
              c.accent-primary.transparentize(50%),
              c.accent-secondary,
              c.accent-primary.transparentize(50%),
            ),
            radius: 1pt,
          )
          #v(4pt)
          #text(size: 12pt, weight: 700, fill: c.text-name)[JOHN DOE]
          #v(2pt)
          #text(size: 8pt, fill: c.accent-primary, style: "italic")[Software Engineer]
          #v(4pt)
          #box(
            inset: (x: 8pt, y: 3pt),
            radius: 8pt,
            fill: c.bg-badge-contact,
          )[
            #text(size: 7pt, fill: c.text-badge-contact)[jdoe\@gmail.com]
          ]
        ]
      ],
      
      // Right: Entry preview
      block(
        width: 100%,
        fill: c.bg-card-entries,
        inset: 10pt,
        radius: 6pt,
        stroke: 1pt + c.border,
      )[
        #grid(
          columns: (1fr, auto),
          align: (left, right),
          text(size: 9pt, weight: 600, fill: c.text-entry-line-1)[ABC Company],
          box(
            inset: (x: 6pt, y: 2pt),
            radius: 6pt,
            fill: c.bg-badge-location,
          )[
            #text(size: 6pt, fill: c.text-badge-location)[Taipei]
          ],
        )
        #v(2pt)
        #grid(
          columns: (1fr, auto),
          align: (left, right),
          text(size: 7pt, weight: 500, fill: c.text-entry-line-2, style: "italic")[Developer],
          box(
            inset: (x: 6pt, y: 2pt),
            radius: 6pt,
            fill: c.bg-badge-date,
          )[
            #text(size: 6pt, fill: c.text-badge-date)[2020-Now]
          ],
        )
        #v(4pt)
        #grid(
          columns: (auto, 1fr),
          gutter: 4pt,
          box(width: 3pt, height: 3pt, fill: c.accent-primary, radius: 50%),
          text(size: 7pt, fill: c.text-body)[Full-stack development]
        )
      ],
    )
    
    #v(6pt)
    
    // Summary preview
    #block(
      width: 100%,
      fill: c.bg-card-summary,
      stroke: (left: 3pt + c.accent-secondary),
      inset: 10pt,
      radius: 4pt,
    )[
      #text(size: 7pt, fill: c.text-body)[
        Experienced professional with passion for technology and innovation.
      ]
    ]
    
    #v(8pt)
  ]
}

// ============================================
// Display all schemes in 2 columns (Page 1)
// ============================================
#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  
  ..schemes.map(((name, scheme)) => display-scheme(name, scheme))
)

#pagebreak()

// ============================================
// Detailed color reference tables (Page 2+)
// ============================================
#align(center)[
  #text(size: 18pt, weight: 700)[
    Detailed Color Reference
  ]
]

#v(16pt)

// Helper function for color table
#let color-table(name, scheme) = {
  let c = scheme.colors
  
  [
    == #name
    
    #table(
      columns: (auto, 1fr, auto),
      stroke: 0.5pt + rgb("#ddd"),
      
      [*Category*], [*Usage*], [*Color*],
      
      // Accents
      table.cell(rowspan: 2)[Accents],
      [Primary (Section titles)],
      box(width: 60pt, height: 20pt, fill: c.accent-primary, radius: 3pt),
      
      [Secondary (Decorations)],
      box(width: 60pt, height: 20pt, fill: c.accent-secondary, radius: 3pt),
      
      // Text
      table.cell(rowspan: 3)[Text],
      [Name],
      box(width: 60pt, height: 20pt, fill: c.text-name, radius: 3pt),
      
      [Body],
      box(width: 60pt, height: 20pt, fill: c.text-body, radius: 3pt),
      
      [Company/School],
      box(width: 60pt, height: 20pt, fill: c.text-entry-line-1, radius: 3pt),
      
      // Background
      table.cell(rowspan: 4)[Background],
      [Page],
      box(width: 60pt, height: 20pt, fill: c.bg-page, stroke: 0.5pt + rgb("#ccc"), radius: 3pt),
      
      [Header Card],
      box(width: 60pt, height: 20pt, fill: c.bg-card-header, stroke: 0.5pt + rgb("#ccc"), radius: 3pt),
      
      [Summary Card],
      box(width: 60pt, height: 20pt, fill: c.bg-card-summary, stroke: 0.5pt + rgb("#ccc"), radius: 3pt),
      
      [Date Badge],
      box(width: 60pt, height: 20pt, fill: c.bg-badge-date, stroke: 0.5pt + rgb("#ccc"), radius: 3pt),
    )
  ]
}

// Display detailed tables for each scheme
#for (idx, (name, scheme)) in schemes.enumerate() [
  #color-table(name, scheme)
  // Only add pagebreak if not the last item
  #if idx < schemes.len() - 1 {
    pagebreak()
  }
]