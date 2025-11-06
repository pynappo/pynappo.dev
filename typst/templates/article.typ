#let article(
  date-created: none,
  date-updated: none,
  authors: (
    (
      name: "pynappo",
      email: "pynappo@proton.me",
    ),
  ),
  tags: ("misc",),
  summary: "",
  rest,
) = context {
  set document(
    author: authors.map(author => author.name),
    keywords: tags,
    date: if (date-updated == none) { date-created } else { date-updated },
    description: summary,
  )
  if target() == "html" {
    html.article()[
      #title()
      #html.div(class: "authors")[
        By: #for author in authors {
          html.span(class: "author")[#author.name (#link("mailto:" + author.email))]
        }
      ]
      #html.div(class: "tags")[
        #for tag in tags {
          html.span(class: "tag")[#tag]
        }
      ] <tags>

      #rest
    ]
  } else {
    [
      Authors:
      #for author in authors {
        [- #author.name #link("mailto:" + author.email)]
      }
    ]
    [
      #for tag in tags {
        tag
      } <tags>
    ]
    rest
  }
}
