# MM-DOCS Template

[![Build status](https://ci.appveyor.com/api/projects/status/1sybv5w5lgywnwc4?svg=true)](https://ci.appveyor.com/project/majkinetor/mm-docs-template)
[![](http://transparent-favicon.info/favicon.ico)](#)
[![](http://transparent-favicon.info/favicon.ico)](#)
[VIEW DEMO](https://majkinetor.github.io/mm-docs-template)

This project is used to produce all forms of documentation for the service using Markdown and other repository friendly markup languages.

The documentation is created using the [mm-docs](https://github.com/majkinetor/mm-docs) documentation bundle.

View how compiled static site looks like on [demo site](https://majkinetor.github.io/mm-docs-template) or grab generated [artifact](https://ci.appveyor.com/project/majkinetor/mm-docs-template/build/artifacts). Check out [pdf export](https://majkinetor.github.io/mm-docs-template/demo/demo.pdf) of [single demo page](https://majkinetor.github.io/mm-docs-template/demo).

See entire docs as a [single page](https://majkinetor.github.io/mm-docs-template/print_page/) and/or [download](https://majkinetor.github.io/mm-docs-template/download/) it.

## Features

- Documentation in Markdown, HTML, PlantUML, MatJax
- Navigational bar, TOC, color themes, search and various rich presentation functionalities
- Beautiful responsive design using the [material](https://squidfunk.github.io/mkdocs-material) theme
- Custom includables that can be imported in any page: footer, header, abbreviations etc.
- Variables, Python macros and jinja templates
- Keep multiple separate documentations in the same project and build only specific one
- PDF export for individual pages or full site
- Bad link checker for internal and external links
- Metainformation for every page - last git modification date, source file, authors, etc.
- GitLab/GitHub repository connection for editing within a browser
- Automated AppVeyor build and deploy to GitHub pages using Ubuntu image
- Live reload during editing
- Cross platform for hosting and development

## Prerequisites

- Docker installation.
  - For Windows Desktop use: `cinst docker-desktop`
- PowerShell (optional, developer friendliness)
  - [Invoke-Build](https://www.powershellgallery.com/packages/InvokeBuild) module

## Usage

Within PowerShell use `Invoke-Build` (ib):

|        Command         |                                             Description                                             |
| ---------------------- | --------------------------------------------------------------------------------------------------- |
| `ib Build`             | Build static site, always set explicit version env var, for example `$Env:MM_DOCS_VERSION = '0.2.2'`                                                                                 |
| `ib Run -aPort 8888`   | Serve static site on port 8888 (default is 8000)<br>This enables concurrent use on several projects |

Otherwise, run appropriate docker commands:

```sh
export image=majkinetor/mm-docs
export aPort=8888

#build
docker run --rm -v $PWD:/docs8 $image mkdocs build

#serve
docker run --rm -v $PWD:/docs --name docs-$aPort --detach -p $aPort:$aPort $image mkdocs serve --dev-addr 0.0.0.0:$aPort
```

## Adding documents

- Add new markdown somewhere in the `source\docs` hierarchy
- To be visible in navigation, add to `source\mkdocs.yml` `nav` section, otherwise, the page is available via direct link
