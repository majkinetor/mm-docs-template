# MM-DOCS Template

[![Build status](https://ci.appveyor.com/api/projects/status/1sybv5w5lgywnwc4?svg=true)](https://ci.appveyor.com/project/majkinetor/mm-docs-template) 
[![](http://transparent-favicon.info/favicon.ico)](#)
[![](http://transparent-favicon.info/favicon.ico)](#)
[VIEW DEMO](https://majkinetor.github.io/mm-docs-template)

This project is used to produce all forms of documentation for the service using Markdown and other repository friendly markup languages.

The documentation is created using the [mm-docs](https://github.com/majkinetor/mm-docs) documentation bundle.

View how compiled static site looks like on [demo site](https://majkinetor.github.io/mm-docs-template) or grab generated [artifact](https://ci.appveyor.com/project/majkinetor/mm-docs-template/build/artifacts). Check out [pdf export](https://majkinetor.github.io/mm-docs-template/demo/demo.pdf) of [single demo page](https://majkinetor.github.io/mm-docs-template/demo).

## Features

- Beautiful responsive design using the [material](https://squidfunk.github.io/mkdocs-material) theme
- Navigational bar, TOC, search and various rich presentation functionalities
- Rich diagrams and interface mockups using PlantUML
- Macros can be written in python
- PDF export for each page or full site
- GitLab/GitHub repository connection for editing within a browser
- Automated AppVeyor build and deploy to GitHub pages using Ubuntu image

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

## Notes

- In order to **use internal Gitlab Docker registry**, make sure daemon setting `insecure-registries` points to the `gitlab.mycompany.com:4567`. On Windows use tray icon and *Settings -> Daemon -> Advanced*.
- Behind the **proxy**, if you pull [Docker Hub](https://hub.docker.com) images, you need to setup docker proxy: *Settings -> Daemon -> Proxies*.
