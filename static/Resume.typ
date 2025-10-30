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
  contact_info: (),
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
    https("linkedin.com/in/put-jhere/"),
  ),
  rest,
) = {
  set page(margin: (
    top: 1cm,
    x: 1.5cm,
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

#let education() = {
  [
    #smallcaps([= Education])
    #line(length: 100%)

    #experience_header(
      [
        == San Jose State University
        _Bachelor of Science in Computer Science -- GPA: 3.91_
      ],
      [
        San Jose, CA #linebreak()
        Aug. 2022 -- May 2025
      ],
      rows: auto,
    )

    *Related coursework:* Data Structures and Algorithms, Object Oriented Design, Processing Big Data, Operating Systems, Computer Architecture, Information Security, Advanced Python, Programming Paradigms, Software Engineering, Database Management Systems.
  ]
}

#let experience() = {
  [
    #smallcaps([= Experience])
    #line(length: 100%)
    #experience_header(
      [
        == Software Development Engineer Intern
        Amazon Web Services
      ],
      [
        May 2025 - August 2025 #linebreak()
        Palo Alto, CA
      ],
      rows: auto,
      left_col: 3fr,
    )
    - Integrated an internal tool to deploy copies of pre-prod infrastructure onto personal AWS accounts, enabling safe
      testing up to 10 minutes faster than previous testing workflows.
    - Resolved a critical CLI bug by collaborating with the internal tooling team, enabling tool compatibility
      with our complex services.
    - Optimized local development builds by removing unnecessary tasks, slashing build times by over 60%.
    - Reduced infra costs by >\$3,000 per month / developer by reconfiguring service scaling on personal accounts.
    - Authored 5 pages of technical documentation on tool usage and maintenance, ensuring long-term sustainability.
    - Drove project velocity across 6 Agile sprints by proactively communicating updates, upcoming work, and blockers.
  ]
}

#let projects() = {
  [
    #smallcaps([= Projects])
    #line(length: 100%)

    #experience_header(
      [== #github("nvim-neo-tree", "neo-tree.nvim")],
      [December 2024 -- Present],
    )
    - Lead maintainer of one of the largest Neovim file-tree plugins, w/ 5,000+ GitHub stars & \~20,000+ users.
    - Cut parsing time for Git statuses by over 50% by optimizing hot paths and deferring work.
    - Engineered a robust GitHub Actions CI pipeline, running hundreds of unit and end-to-end tests to ensure stability across multiple Neovim
      versions and operating systems.
    - Refactored 3,000+ lines of Lua code to be type-annotated for improved developer experience.
    - Personally fixed 70+ issues - non-ASCII text handling, performance issues, user feature requests, UI bugs, etc.

    #experience_header(
      [== #link("https://devpost.com/software/storycraft", [storycraft 🔗])],
      [April 2024],
    )
    - Led a team of 4 to build an AI interactive storytelling app that won "Best AI Hack" at SFHacks 2024.
    - Engineered prompts for Mixtral 8x7B and Stable Diffusion XL to generate stylized stories based on user choices.
    - Implemented our designer's front-end UI designs from Figma in React components using Tailwind CSS.
    - Constructed REST end-points backed by MongoDB and AWS S3 to store stories, characters, and illustrations.

    #experience_header(
      [== #link("https://github.com/danknessdra/rmpdev", [ProfessorSearch 🔗])],
      [February 2024 -- June 2024],
    )
    - Developed a SvelteKit web app to provide an improved search and filtering UI for _#https("ratemyprofessor.com")_ (RMP) data.
    - Scraped RMP's GraphQL API with Python and Postman queries to retrieve updated data across 1000s of schools.
    - Wrote a TypeScript service to fetch professor data by school on-demand, improving initial search latency by >90%.
    - Integrated Elasticsearch to index 10+ MB of professor data, achieving sub-second search and aggregation latency.
    - Designed the front-end UI with shadcn-svelte and Tailwind CSS for a modern UI.
    - Containerized the app and services using Docker Compose for consistent local development and deployment.
  ]
}

#let technologies() = {
  [
    = #smallcaps([Technologies])
    #line(length: 100%)
    - *Languages:* C\#, Java, TypeScript/JavaScript, HTML, CSS (+ SASS/Less), Python, Lua, Go, C, C++, SQL
    - *Web frameworks/UI libraries:* React/Next.js, Svelte/SvelteKit, Tailwind CSS, daisyUI, Shoelace
    - *Services:* MongoDB, PostgreSQL, Prisma, AWS S3, ElasticSearch, MySQL
    - *Tools/OS:* Git, Neovim, IntelliJ, Docker, Postman, Bash/ZSH, Linux/Unix, GitHub Actions
  ]
}

#experience()
#education()
#projects()
#technologies()
