# MM-DOCS

This project is used to produce all forms of documentation for the service using Markdown and other repository friendly markup languages.

The documentation is created using the mm-docs docker bundle:

- https://github.com/majkinetor/mm-docs

## Features

- Write documentation in extended Markdown, HTML, PlantUML and other markup languages
- Beautiful responsive design using material theme
- Navigational bar, TOC, search, internationalization, and various rich presentation functionalities
- Rich diagrams and interface mockups using PlantUML
- Macros can be written in python
- PDF export for each page or full site
- Live reload during editing
- GitLab/GitHub repository connection for editing within a browser
- Automated AppVeyor build and deploy to GitHub pages using Ubuntu image
- Cross platform for hosting and development

## Prerequisites

- Docker
- PowerShell (optional, but recommended)

## Quick start

To edit documentation:

- Clone [new project template](https://github.com/majkinetor/mm-docs-template)
- Start development server - run in PowerShell `Invoke-Build Run`. The command is syntax sugar for running docker containers
- Add new documents somewhere in the `source\docs` hierarchy. To be visible in navigation, add to the path to the file in `source\mkdocs.yml` section `nav`, otherwise, the page is available via direct link.

To build static site run `Invoke-Build Build`.

{!footer.md!}
