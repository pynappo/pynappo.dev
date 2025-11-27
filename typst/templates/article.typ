#let category-tab(name: "") = context {
  if target() == "html" {
    html.a(class: "tag", href: "/blog/by-tag/" + name)[name <tag>]
  } else {
    [[#name <tag>]]
  }
}

#let sidenote(body) = context {
  if target() == "html" {} else {
    [(sidenote: #body)]
  }
}

#let article(
  date-published: none,
  date-updated: none,
  article-title: "Placeholder Title",
  authors: (
    (
      name: "pynappo",
      email: "pynappo@proton.me",
    ),
  ),
  tags: ("misc",),
  summary: "",
  title-override: none,
  rest,
) = context {
  set document(
    title: article-title,
    author: authors.map(author => author.name),
    keywords: tags,
    date: if (date-updated == none) { date-published } else { date-updated },
    description: summary,
  )
  title()
  [#metadata(article-title) <title>]
  if target() == "html" {
    html.article()[
      #html.div(class: "authors")[
        By: #for author in authors {
          html.span(class: "author")[#author.name (#link("mailto:" + author.email))]
        }
      ]
      #html.div(class: "tags")[
        #for tag in tags {
          category-tab(name: tag)
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
      Tags:
      #for tag in tags {
        [- #category-tab(name: tag)]
      }
    ]
    rest
  }
}
