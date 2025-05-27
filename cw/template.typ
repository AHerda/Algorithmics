// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(
  title: [],
  abstract: none,
  authors: (),
  date: none,
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set page(
    numbering: "1",
    number-align: center,
    header:  context { if (counter(page).get().at(0) != 1)  [
      #set text(9pt)
      #title
      #h(1fr)
      #if authors.len() > 3 [
        #authors.map(author => author.name.split().at(0).first() + ". " + author.name.split().at(1)).join(", ")
      ] else [
        #authors.map(author => author.name).join(", ")
      ]
      #line(length: 100%)
    ]},
    header-ascent: 20%
  )
  set text(lang: "pl")
  show math.equation: set text(weight: 400)
  show heading: set block(below: 1em, above: 2em)

  // Title row.
  align(top + center)[
    #text(size: 24pt, [#title])
  ]

  // Author information.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center)[
        *#author.name* \
        #author.affiliation
      ]),
    ),
  )

  align(top + center)[
    #date
  ]

  // Main body.
  set par(justify: true)

  if abstract != none {
    heading(outlined: true, numbering: none, text(0.85em, [Abstract]))
    abstract
  }

  body
}
