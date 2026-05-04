#let resume(
  author: "",
  author-position: left,
  personal-info-position: left,
  pronouns: "",
  location: "",
  email: "",
  github: "",
  linkedin: "",
  phone: "",
  personal-site: "",
  accent-color: "#000000",
  font: "New Computer Modern",
  paper: "us-letter",
  author-font-size: 20pt,
  font-size: 10pt,
  lang: "en",
  body,
) = {

  // Sets document metadata
  set document(author: author, title: author)

  // Document-wide formatting, including font and margins
  set text(
    // LaTeX style font
    font: font,
    size: font-size,
    lang: lang,
    // Disable ligatures so ATS systems do not get confused when parsing fonts.
    ligatures: false
  )

  // Reccomended to have 0.5in margin on all sides
  set page(
    margin: (0.5in),
    paper: paper,
  )

  // Link styles
  show link: underline


  // Small caps for section titles
  show heading.where(level: 2): it => [
    #pad(top: 0pt, bottom: -10pt, [#smallcaps(it.body)])
    #line(length: 100%, stroke: 1pt)
  ]

  // Accent Color Styling
  show heading: set text(
    fill: rgb(accent-color),
  )

  show link: set text(
    fill: rgb(accent-color),
  )

  // Name will be aligned left, bold and big
  show heading.where(level: 1): it => [
    #set align(author-position)
    #set text(
      weight: 700,
      size: author-font-size,
    )
    #pad(it.body)
  ]

  // Level 1 Heading
  [= #(author)]

  // Personal Info Helper
  let contact-item(value, prefix: "", link-type: "") = {
    if value != "" {
      if link-type != "" {
        link(link-type + value)[#(prefix + value)]
      } else {
        value
      }
    }
  }

  // Personal Info
  pad(
    top: 0.25em,
    align(personal-info-position)[
      #{
        let items = (
          contact-item(pronouns),
          contact-item(phone),
          contact-item(location),
          contact-item(email, link-type: "mailto:"),
          contact-item(github, link-type: "https://"),
          contact-item(linkedin, link-type: "https://"),
          contact-item(personal-site, link-type: "https://"),
        )
        items.filter(x => x != none).join("  |  ")
      }
    ],
  )

  // Main body.
  set par(justify: true)

  body
}

// Generic two by two component for resume
#let generic-two-by-two(
  top-left: "",
  top-right: "",
  bottom-left: "",
  bottom-right: "",
) = {
  [
    #top-left #h(1fr) #top-right \
    #bottom-left #h(1fr) #bottom-right
  ]
}

// Generic one by two component for resume
#let generic-one-by-two(
  left: "",
  right: "",
) = {
  [
    #left #h(1fr) #right
  ]
}

// Cannot just use normal --- ligature becuase ligatures are disabled for good reasons
#let dates-helper(
  start-date: "",
  end-date: "",
) = {
  start-date + " " + $dash.em$ + " " + end-date
}

// Section components below
#let edu(
  institution: "",
  dates: "",
  degree: "",
  gpa: "",
  location: "",
  // Makes dates on upper right like rest of components
  consistent: false,
) = {
  if consistent {
    // edu-constant style (dates top-right, location bottom-right)
    generic-two-by-two(
      top-left: strong(institution),
      top-right: dates,
      bottom-left: emph(degree),
      bottom-right: emph(location),
    )
  } else {
    // original edu style (location top-right, dates bottom-right)
    generic-two-by-two(
      top-left: strong(institution),
      top-right: location,
      bottom-left: emph(degree),
      bottom-right: emph(dates),
    )
  }
}

#let work(
  title: "",
  dates: "",
  company: "",
  location: "",
) = {
  generic-two-by-two(
    top-left: strong(title),
    top-right: dates,
    bottom-left: company,
    bottom-right: emph(location),
  )
}

#let project(
  role: "",
  name: "",
  url: "",
  dates: "",
) = {
  generic-one-by-two(
    left: {
      if role == "" {
        [*#name* #if url != "" and dates != "" [ (#link("https://" + url)[#url])]]
      } else {
        [*#role*, #name #if url != "" and dates != ""  [ (#link("https://" + url)[#url])]]
      }
    },
    right: {
      if dates == "" and url != "" {
        link("https://" + url)[#url]
      } else {
        dates
      }
    },
  )
}

#let certificates(
  name: "",
  issuer: "",
  url: "",
  date: "",
) = {
  [
    *#name*, #issuer
    #if url != "" {
      [ (#link("https://" + url)[#url])]
    }
    #h(1fr) #date
  ]
}

#let extracurriculars(
  activity: "",
  dates: "",
) = {
  generic-one-by-two(
    left: strong(activity),
    right: dates,
  )
}

// Put your personal information here, replacing mine
#let name = "Imam Rafii Al Dzakwan"
#let location = "Jakarta, Indonesia"
#let email = "imamrafiia@gmail.com"
#let github = "github.com/IktaS"
#let linkedin = "linkedin.com/in/imamrafiia"
#let personal-site = "ikta.dev"

#show: resume.with(
  author: name,
  // All the lines below are optional.
  // For example, if you want to to hide your phone number:
  // feel free to comment those lines out and they will not show.
  location: location,
  email: email,
  github: github,
  linkedin: linkedin,
  // phone: phone,
  personal-site: personal-site,
  accent-color: "#26428b",
  font: "New Computer Modern",
  paper: "us-letter",
  author-position: left,
  personal-info-position: left,
)

Backend-focused Lead Software Engineer (3.5 YOE) with strong experience in system design, service optimization, and distributed systems. Proven track record improving system performance (e.g., 2x processing speed, 50% DB load reduction, 80% memory reduction) and leading major architectural initiatives, including microservices, observability, deployment pipelines, and real-time settlement systems. Skilled in Go, PostgreSQL, Kafka, Kubernetes, and large-scale financial systems. Experienced in payment integrations, reconciliation automation, and building robust internal platforms. IELTS 7.5 and JLPT N3 certified.

== Work Experience

#work(
  title: "Senior Software Engineer",
  location: "Earth, Solar System",
  company: "Deel.com",
  dates: dates-helper(start-date: "February 2026", end-date: "Present"),
)
- Payroll Integration EMS <\-> PMS Migration
  - In my first few months, I am taking on the responsibility of migrating some deprecated endpoints of the Deel Employment Service to Payroll Management Service
- Payroll Group and Vendor Mapping Stabilization
  - Reviewed the flow and bugs inside Payroll Group and Vendor Mapping flow
  - Communicated with stakeholder on the usage of this flow
  - Fixed all bugs and created additional improvement to guarantee 100% success rate of the flows.


#work(
  title: "Lead Software Engineer",
  location: "Jakarta, ID",
  company: "Durianpay.id",
  dates: dates-helper(start-date: "Aug 2024", end-date: "February 2026"),
)
- Overall System and Process Optimization
  - Integrated Go’s profiler in order to identify and optimize the memory usage of services. In one instance finding an Excel parsing optimization that leads to 80% reduction of memory usage.
  - Spearheaded the usage of pg_repack in PostgreSQL in our current system in order to optimize database processes while not affecting normal traffic.
  - Identified old bad practices and leading company wide policy change to better engineering practices. Including things like making coding guidelines regarding Idiomatic Go, gave engineering wide talk on the bad patterns currently in our code
  - Lead the ideation of new deployment pipelines that allow for parallel independent deployment for each squads in order to keep up with the scaling of the team. Together with DevOps team, defined a new Jenkins Pipeline and Kubernetes deployment flow.
  - Implement system observability using VictoriaMetrics and Grafana.
- Design and implement a new settlement processing flow.
  - Spearheaded the design and implementation of a new settlement flow, resulting in a 100% increase in processing speed and a 50% reduction in database load.
  - Identified key inefficiencies in the previous settlement flow, including bottlenecks and high database load, through an in-depth analysis of system performance and transaction.
- Designed and implemented Realtime Settlement
  - Designed and developed a feature in which using our connected bank accounts that allow for almost real time settlement, with SLA between when the money is received to settled to merchant’s bank in under 30 minute.
  - Using Kafka for cross-service integration, implemented a Saga pattern in microservice to orchestrate a cross-service, cross-team function.
- Designed an Automatic Settlement Reconciliation System from Email.
  - Developed custom scripts and tools to securely retrieve and parse settlement-related emails, streamlining the reconciliation process and improving accuracy.
  - Reduced manual intervention, eliminating common errors and discrepancies associated with manual data entry and reconciliation.
- Designed Automated Settlement Scheduler
  - Led the design and implementation of an automated settlement scheduler, streamlining the process and ensuring accurate, timely settlements without manual intervention.

#work(
  title: "Software Engineer",
  location: "Jakarta, ID",
  company: "Durianpay.id",
  dates: dates-helper(start-date: "Aug 2023", end-date: "Jul 2024"),
)
- Internal Approval & Processing System: Designed and implemented a highly extendable internal approval and processing system, reducing human error by requiring multiple approvals for each action. Initially built for 2 actions, the system now supports over 40 actions, with no need for fixes to the main flow. The design is intuitive, scalable, and easy to maintain.
- Indonesia’s Standardized Payment API (SNAP): Led the integration of the new national SNAP payment API into our platform. Acted as the primary liaison with the National Bank teams to ensure seamless implementation and compliance with local payment standards
- Direct Bank Integration for Payments: Spearheaded the end-to-end flow for accepting debit and credit card payments. This involved integrating CIMB Bank’s API to facilitate credit card transactions and implementing the payment settlement process, further enhancing the system’s capability for real-time payment processing

#work(
  title: "Associate Software Engineer ",
  location: "Jakarta, ID",
  company: "Durianpay.id",
  dates: dates-helper(start-date: "Jan 2023", end-date: "Jul 2023"),
)
- Dynamic Disbursement System: Collaborated with the team to design and implement a dynamic disbursement system that selects the most cost-effective and stable payment rails for each transaction. This innovation reduced transaction costs by up to 93%, from Rp 1500 per transaction to just Rp 100, significantly enhancing Durianpay’s profitability on each disbursement by 93%

#work(
  title: "Tokopedia.com Backend Software Engineer",
  location: "Jakarta, ID",
  company: "Tokopedia.com",
  dates: dates-helper(start-date: "Aug 2022", end-date: "Nov 2022"),
)
- Lead the development of a new feature in the core team for users to be able to refund their order in case Tokopedia’s Third Party Provider has issues fulfilling their bills, thus reducing the need for Tokopedia Customer Service to handle every refund request. This feature is used 2500 times a week, reducing the workload of CS team by 70%.

#work(
  title: "Backend Software Engineer Intern",
  location: "Jakarta, ID",
  company: "Tokopedia.com",
  dates: dates-helper(start-date: "Feb 2022", end-date: "Jul 2022"),
)
- Maintain the core service of Bills and Top up Team. Mainly the checkout system of digital bills products in Tokopedia.com
- Notable projects: Migrating legacy code REST API to gRPC

// #work(
//   title: "Backend Software Engineer Intern",
//   location: "Jakarta, ID",
//   company: "Bukalapak.com",
//   dates: dates-helper(start-date: "Jun 2021", end-date: "Sep 2021"),
// )
// - Part of the Core Search team that works on maintaining the main Elasticsearch system that is used for the main search feature of Bukalapak.com
// - Designed and implemented dynamic search query configuration system

/*
* Lines that start with == are formatted into section headings
* You can use the specific formatting functions if needed
* The following formatting functions are listed below
* #edu(dates: "", degree: "", gpa: "", institution: "", location: "", consistent: false)
* #work(company: "", dates: "", location: "", title: "")
* #project(dates: "", name: "", role: "", url: "")
* certificates(name: "", issuer: "", url: "", date: "")
* #extracurriculars(activity: "", dates: "")
* There are also the following generic functions that don't apply any formatting
* #generic-two-by-two(top-left: "", top-right: "", bottom-left: "", bottom-right: "")
* #generic-one-by-two(left: "", right: "")
*/
== Education

#edu(
  institution: "Sepuluh November Institute of Technology",
  location: "Surabaya, ID",
  dates: dates-helper(start-date: "Aug 2018", end-date: "Sep 2022"),
  degree: "Bachelor's of Informatics, Informatics",

  // Uncomment the line below if you want edu formatting to be consistent with everything else
  // consistent: true
)
- Cumulative GPA: 3.77\/4.0
- Relevant Coursework: Data Structures, Program Development, Software Engineering, Distributed Databases, Distributed Systems


== Projects

#project(
  name: "Ikta.dev: Linux Sandbox",
  // Role is optional
  role: "Maintainer",
  // Dates is optional
  // dates: dates-helper(start-date: "Nov 2023", end-date: "Present"),
  // URL is also optional
  url: "ikta.dev",
)
- A complete linux sandbox in your browser. Using websockets and pty to exec into a containerized alpine linux sandbox where user can execute functions but still constrained within the sandbox itself.

#project(
  name: "Mata Futsal",
  // Role is optional
  role: "Maintainer",
  // Dates is optional
  // dates: dates-helper(start-date: "Nov 2023", end-date: "Present"),
  // URL is also optional
  url: "matafutsal.com",
)
- A field booking system used by Mata Futsal in order to collaborate between employees regarding which field is empty at what time.

#project(
  name: "NFC Music Player",
  // Role is optional
  role: "Maintainer",
  // Dates is optional
  // dates: dates-helper(start-date: "Nov 2023", end-date: "Present"),
  // URL is also optional
  url: "youtu.be/J3ycUL5_f4s",
)
- A NFC Triggered Music Player for playing physical discs the hassle free way. Using ESP32, PN532, foobar2000, a custom desktop controller written in python, this product is able to trigger playing of local file using an NFC tag attached to the back of an album.
- Designed to be used in conventions or storefronts.

// == Extracurricular Activities

// #extracurriculars(
//   activity: "Capture The Flag Competitions",
//   dates: dates-helper(start-date: "Jan 2021", end-date: "Present"),
// )
// - Founder of Les Amateurs (#link("https://amateurs.team")[amateurs.team]), currently ranked \#4 US, \#33 global on CTFTime (2023: \#4 US, \#42 global)
// - Organized AmateursCTF 2023 and 2024, with 1000+ teams solving at least one challenge and \$2000+ in cash prizes
//   - Scaled infrastructure using GCP, Digital Ocean with Kubernetes and Docker; deployed custom software on fly.io
// - Qualified for DEFCON CTF 32 and CSAW CTF 2023, two of the most prestigious cybersecurity competitions globally

// #extracurriculars(
//   activity: "Science Olympiad Volunteering",
//   dates: "Sep 2023 --- Present"
// )
// - Volunteer and write tests for tournaments, including LA Regionals and SoCal State \@ Caltech

== Certificates
- #certificates(
  name: "IELTS 7.5",
  issuer: "IELTS",
  // url: "",
  date: "Oct 2024",
)
- #certificates(
  name: "JLPT N3",
  issuer: "JLPT",
  // url: "",
  date: "Aug 2025",
)

== Skills & Interest
- *Programming Languages*: Go, Python, JavaScript, Typescript, C\#
- *Technologies*: PostgreSQL. Redis, Kafka, AWS, Elasticsearch, gRPC, Grafana, Kubernetes, GraphQL
- *Interests*: Backend Engineering, IoT, Distributed Systems, Manufacturing, Game Programming
