#let experience_header(
  left_content,
  right_content,
  left_col: 2fr,
  right_col: 1fr,
  rows: 1mm,
) = {
  grid(
    columns: (left_col, right_col),
    rows: rows,
    align(left)[#left_content], align(right)[#right_content],
  )
}

#let https(short_link) = {
  link("https://" + short_link)[#short_link]
}

#let github(author, repo) = {
  link("https://github.com/" + author + "/" + repo)[#repo 🔗]
}

#let resume_header(
  name: "pynappo",
  location: "San Jose, CA",
  contact_info: (
    https("github.com/pynappo"),
    [Mobile: (xxx) xxx-xxxx],
    link("mailto:pynappo@proton.me"),
    https("linkedin.com/in/your-linkedin-here/"),
  ),
) = {
  set align(center)
  box(fill: gradient.linear(rgb("EFFFEF"), rgb("EFEFFF")), outset: (
    x: 100pt,
    y: 11pt,
  ))[
    = #name
    #location #linebreak()
    #array.join(contact_info, [ \u{2022} ])
  ]
}

#let resume(
  name: "pynappo",
  location: "San Jose, CA",
  contact_info: (
    https("github.com/pynappo"),
    [Mobile: +1 (xxx) xxx-xxxx],
    link("mailto:pynappo@proton.me"),
    https("linkedin.com/in/here/"),
  ),
  rest,
) = {
  set page(margin: (
    top: 1cm,
    x: 1.75cm,
    bottom: 1cm,
  ))

  set page(
    paper: "us-letter",
  )
  // minimal padding
  show heading: set block(below: 0.08in, above: 0.2in)
  show line: set block(below: 0.1in)

  resume_header(contact_info: contact_info, location: location, name: name)
  rest
}

#show: resume

#smallcaps([= Experience])
#line(length: 100%)
#experience_header(
  [== Amazon Web Services -- Software Development Engineer Intern],
  [May 2025 - August 2025],
  left_col: 3fr,
)
- Added tooling to deploy pre-prod infrastructure to developer AWS accounts, cutting test times by over 70%.
- Trimmed out unnecessary build tasks on local machines, cutting local build times by over 50%.
- Wrote 5 pages of technical documentation on how to use the tooling, how to debug it, and additional plans.
- Communicated updates and planned work over 6 Agile sprints.

#smallcaps([= Education])
#line(length: 100%)

#experience_header(
  [
    == San Jose State University
    _Bachelor of Science in Computer Science - GPA: 3.91_
  ],
  [August 2022 -- Graduated May 2025],
  rows: auto,
)

*Related coursework:* Data Structures and Algorithms, Object Oriented Design, Processing Big Data, Operating Systems, Computer Architecture, Information Security, Advanced Python, Programming Paradigms, Software Engineering, Database Management Systems.

#smallcaps([= Projects])
#line(length: 100%)
#experience_header(
  [== #link("https://devpost.com/software/storycraft", [storycraft 🔗])],
  [April 2024],
)
- Led a team of 4 to build an AI interactive storytelling app that won "Best AI Hack" at SFHacks 2024.
- Tuned Mixtral 8x7B MoE LLM for story and user choices, and Stable Diffusion XL for styled illustrations.
- Implemented our designer's front-end UI designs in React (Next.js) with Tailwind CSS components.
- Constructed REST end-points backed by MongoDB and AWS S3 to store stories, characters, and illustrations.

#experience_header(
  [== #github("nvim-neo-tree", "neo-tree.nvim")],
  [December 2024 -- Present],
)
- Lead maintainer of one of the largest Neovim file-tree plugins, w/ 5,000+ GitHub stars & \~20,000+ users.
- Improved parsing performance by over 200% for Git statuses by optimizing hot paths and deferring work.
- Built a CI pipeline to test 14k lines of code against multiple Neovim versions and operating systems.
- Refactored 3,000+ lines of Lua code to be type-annotated for ease of development.
- Personally fixed 70+ issues - non-ASCII text handling, performance issues, user feature requests, UI bugs, etc.

#experience_header(
  [== #link("https://github.com/danknessdra/rmpdev", [ProfessorSearch 🔗])],
  [February 2024 -- June 2024],
)
- A SvelteKit web UI for _#https("ratemyprofessor.com")_ (RMP) with improved search and filter capabilities.
- Scraped RMP's GraphQL API with Python, then pushed the data to ElasticSearch via a TypeScript backend.
- Designed a cohesive UI with shadcn-svelte and Tailwind CSS to quickly prototype an MVP.
- Containerized SvelteKit and Elasticsearch into Docker for consistent deployments.

= #smallcaps([Technologies])
#line(length: 100%)
- *Languages:* C\#, Java, TypeScript/JavaScript, HTML, CSS (+ SASS/Less), Python, Lua, Go, C, C++, SQL
- *Web frameworks/UI libraries:* React/Next.js, Svelte/SvelteKit, Tailwind CSS, daisyUI, Shoelace
- *Services:* MongoDB, PostgreSQL, Prisma, AWS S3, ElasticSearch, MySQL
- *Tools/OS:* Git, Neovim, IntelliJ, Docker, Postman, Bash/ZSH, Linux/Unix, GitHub Actions
