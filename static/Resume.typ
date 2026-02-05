#let experience_header(
  technologies: "",
  left_col: 2fr,
  right_col: 1fr,
  rows: 1mm,
  left_content,
  right_content,
) = {
  show heading.where(level: 2): it => {
    set text(14pt)
    it
  }
  grid(
    columns: (left_col, right_col),
    rows: rows,
    align(left)[#box[#left_content]], align(right)[#right_content],
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
  box(
    fill: gradient.linear(
      // rgb("EFFFEF"),
      // rgb("EFEFFF"),
      rgb("FFFFFF"),
      rgb("FFFFFF"),
    ),
    outset: (
      x: 100pt,
      y: 11pt,
    ),
  )[
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
    https("linkedin.com/in/put-here/"),
  ),
  rest,
) = {
  set page(
    paper: "us-letter",
    margin: (
      top: 1cm,
      x: 1.5cm,
      bottom: 1cm,
    ),
  )
  // minimal padding
  show heading: set block(below: 0.08in, above: 0.2in)
  show line: set block(below: 0.1in)

  resume_header(contact_info: contact_info, location: location, name: name)
  rest
}

#let related-classes = (
  "Data Structures and Algorithms",
  "Information Security",
  "Object Oriented Design",
  "Processing Big Data",
  "Operating Systems",
  "Computer Architecture",
  // "Advanced Python",
  // "Programming Paradigms",
  "Software Engineering",
  "Database Management Systems",
)


#let education(grad-date: [May 2025]) = {
  [
    = #smallcaps([Education])
    #line(length: 100%)

    #experience_header(
      [
        == San Jose State University
        _Bachelor of Science in Computer Science -- GPA: 3.91_
      ],
      [
        San Jose, CA #linebreak()
        Aug. 2022 -- #grad-date
      ],
      rows: auto,
    )
  ]
}

#let classes() = {
  [
    *Related coursework:* #related-classes.join(", ", last: ", and ").
  ]
}

#let experience() = {
  [
    = #smallcaps([Experience])
    #line(length: 100%)
    #experience_header(
      [
        == Software Development Engineer Intern
        Amazon Web Services
      ],
      [
        May 2025 - August 2025 #linebreak()
        Bay Area, CA
      ],
      rows: auto,
      left_col: 3fr,
    )
    - Integrated an internal tool in Java to deploy pre-production data processing infrastructure onto personal AWS
      accounts via CloudFormation, enabling safer testing up to 10 minutes faster than previous testing workflows.
    - Resolved a CLI bug by collaborating with the internal tooling team, enabling tool compatibility for our codebase.
    - Optimized local development builds by skipping unnecessary tasks, cutting build times by over 60%.
    // - Reduced infra costs by >\$1,000 per month / developer by reconfiguring service scaling on personal accounts.
    - Authored 5 pages of technical documentation on tool usage, project status, and future maintenance, ensuring
      long-term sustainability and maintainability.
    // - Drove project velocity across 6 Agile sprints by proactively communicating updates, upcoming work, and blockers.
  ]
}

#let projects() = {
  [
    #smallcaps([= Projects])
    #line(length: 100%)

    #experience_header(
      [*#github("nvim-neo-tree", "neo-tree.nvim")* | CI/CD, Lua, Unix/Linux/Windows],
      [December 2024 -- Present],
    )
    - Lead maintainer of one of the largest Neovim file-tree plugins, with 5.2k+ GitHub stars.
    - Engineered a robust GitHub Actions CI pipeline, running hundreds of unit and end-to-end tests using the Busted
      framework to ensure stability across multiple Neovim versions and operating systems.
    - Refactored 3,000+ lines of code to be thoroughly type-annotated for improved developer experience.
    - Personally resolved 80+ issues - non-ASCII text handling, performance issues, user feature requests, and UI bugs.
    - Overhauled Git integration to improve parsing time by >70% and allow for tracking multiple repos at once.
    // - Improved user documentation by simplifying technical wording, documenting edge cases, and listing common configuration tweaks.

    #experience_header(
      [*#link("https://devpost.com/software/storycraft", [storycraft 🔗])* | AI/LLM, TypeScript,
        React, CSS, MongoDB, AWS S3],
      [April 2024],
    )
    - Led a team of 4 to build an AI interactive storytelling app in 2 days that won "Best AI Hack" at SFHacks 2024.
    - Engineered AI prompts for Mixtral 8x7B and Stable Diffusion XL to generate stylized choose-your-own-adventure stories and pictures.
    - Wrote a system to summarize previous story points in subsequent prompts, improving story consistency when using
      LLMs with smaller context windows.
    - Implemented our designer's frontend UI designs from Figma in React components using Tailwind CSS.
    - Stored prompts in MongoDB and illustrations in an AWS S3 bucket to automatically save and restore stories.

    #experience_header(
      [*#link("https://github.com/danknessdra/rmpdev", [ProfessorSearch 🔗])* | SvelteKit,
        GraphQL, TypeScript, Docker, Python],
      [February 2024 -- June 2024],
    )
    - Developed a SvelteKit web app to provide an improved search and filtering UI for _#https("ratemyprofessor.com")_ (RMP) data.
    - Scraped RMP's GraphQL API with Python and Postman queries to retrieve updated data across 1000s of schools.
    - Wrote a TypeScript service to fetch professor data by school on-demand, improving initial search latency by >90%.
    - Integrated Elasticsearch to index 10+ MB of professor data, achieving sub-second search latency.
    - Designed a modern frontend UI with shadcn-svelte and Tailwind CSS.
    - Containerized the app and services using Docker Compose for consistent local development and deployment.

    // #experience_header(
    //   [*#link(
    //       "https://github.com/PrabhnoorKhatkar/CS157A-Team10",
    //       [Brushstroke Bargains 🔗],
    //     )* | MySQL, Java, JSP, Shoelace, HTML, CSS],
    //   [October 2024 -- December 2024],
    // )
    // - Secured user data using email + password authentication (with SHA256 hashing) in MySQL + Java.
    // - Modernized the front-end UI using Shoelace web components and CSS animations.
  ]
}

#let technologies() = {
  [
    = #smallcaps([Technologies])
    #line(length: 100%)
    - *Languages:* C\#, Java, TypeScript/JavaScript, HTML, CSS (+ SASS/Less), Python, Lua, Go, C, C++, SQL
    - *Web frameworks/UI libraries:* React/Next.js, Svelte/SvelteKit, Tailwind CSS, daisyUI, Shoelace
    - *Services:* MongoDB, PostgreSQL, Prisma, AWS S3, ElasticSearch, MySQL
    - *Tools/OS:* Git, Neovim, IntelliJ, Eclipse, Docker, Postman, Bash/ZSH, Linux/Unix, GitHub Actions
  ]
}

#show: resume
#experience()
#education()
#classes()
#projects()
#technologies()

_Disclaimer: For a resume with more specific information, please contact me at #link("mailto:pynappo@proton.me"). Resume
generated with Typst._
