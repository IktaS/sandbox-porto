#import "@local/basic-resume-html:1.0.0": *

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

== Work Experience

#work(
  title: "Lead Software Engineer",
  location: "Jakarta, ID",
  company: "Durianpay.id",
  dates: dates-helper(start-date: "Aug 2024", end-date: "Present"),
)
- Overall System and Process Optimization
  - Integrated Go’s profiler in order to identify and optimize the memory usage of services. In one instance finding an Excel parsing optimization that leads to 80% reduction of memory usage.
  - Spearheaded the usage of pg_repack in PostgreSQL in our current system in order to optimize database processes while not affecting normal traffic.
  - Identified old bad practices and leading company wide policy change to better engineering practices.
  - Lead the ideation of new deployment pipelines that allow for parallel independent deployment for each squads in order to keep up with the scaling of the team. Together with DevOps team, defined a new Jenkins Pipeline and Kubernetes deployment flow.
  - Implement system observability using VictoriaMetrics and Grafana.
- Design and implement a new settlement processing flow.
  - Spearheaded the design and implementation of a new settlement flow, resulting in a 100% increase in processing speed and a 50% reduction in database load.
  - Identified key inefficiencies in the previous settlement flow, including bottlenecks and high database load, through an in-depth analysis of system performance and transaction.
- Designed and implemented Realtime Settlement
  - Designed and developed a feature in which using our connected bank accounts that allow for almost real time settlement, with SLA between when the money is received to settled to merchant’s bank in under 30 minute.
  - Using Kafka for cross-service integration, implemented a Saga pattern in microservice to orchestrate a cross-service, cross-team function.
// - Designed an Automatic Settlement Reconciliation System from Email.
//   - Developed custom scripts and tools to securely retrieve and parse settlement-related emails, streamlining the reconciliation process and improving accuracy.
//   - Reduced manual intervention, eliminating common errors and discrepancies associated with manual data entry and reconciliation.
// - Designed Automated Settlement Scheduler
//   - Led the design and implementation of an automated settlement scheduler, streamlining the process and ensuring accurate, timely settlements without manual intervention.

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

#work(
  title: "Backend Software Engineer Intern",
  location: "Jakarta, ID",
  company: "Bukalapak.com",
  dates: dates-helper(start-date: "Jun 2021", end-date: "Sep 2021"),
)
- Part of the Core Search team that works on maintaining the main Elasticsearch system that is used for the main search feature of Bukalapak.com
- Designed and implemented dynamic search query configuration system

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
#certificates(
  name: "IELTS 7.5",
  issuer: "IELTS",
  // url: "",
  date: "Oct 2024",
)
#certificates(
  name: "JLPT N3",
  issuer: "JLPT",
  // url: "",
  date: "Aug 2025",
)

== Skills & Interest
- *Programming Languages*: Go, Python, JavaScript, Typescript, C\#
- *Technologies*: PostgreSQL. Redis, Kafka, AWS, Elasticsearch, gRPC, Grafana, Kubernetes, GraphQL
- *Interests*: Backend Engineering, IoT, Distributed Systems, Manufacturing, Game Programming
