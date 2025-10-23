#let article(
  date-published: "",
  date-updated: "",
  authors: (
    (
      name: "pynappo",
      email: "pynappo@proton.me",
    ),
  ),
  rest,
) = {
  set align(center)
  for author in authors {
    [
      #author.name #link("mailto:" + author.email)
    ]
  }

  set align(left)

  rest
}
