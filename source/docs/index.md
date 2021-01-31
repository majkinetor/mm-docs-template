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
- Single page with entire documentation
- Live reload during editing
- GitLab/GitHub repository connection for editing within a browser
- Automated AppVeyor build and deploy to GitHub pages using Ubuntu image
- Cross platform for hosting and development

## Prerequisites

- Docker
- PowerShell (optional, developer friendliness)
    - [Invoke-Build](https://www.powershellgallery.com/packages/InvokeBuild) module

## Quick start

To edit documentation:

- Clone/use [new project template](https://github.com/majkinetor/mm-docs-template)
- Add new documents somewhere in the `source\docs` hierarchy.
- Add document path to TOC (file: `source\mkdocs.yml`; yaml key: `nav`) to make page visible in the navigation section, otherwise, the page is available via direct link.

Start development server - run in PowerShell `Invoke-Build Run`. The command is syntax sugar for running docker containers.
To build static site run `Invoke-Build Build`.

{% include 'footer.md' %}
