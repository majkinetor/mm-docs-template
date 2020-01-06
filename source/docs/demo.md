# Demonstration page

[mm-docs](https://github.com/majkinetor/mm-docs) demonstration page.

For more details about included tools see:

- [Mkdocs](https://www.mkdocs.org)
- [Mkdocs Material Extensions](https://squidfunk.github.io/mkdocs-material/extensions/admonition)
- [PlantUML](http://plantuml.com)
- [MathJax](https://www.mathjax.org/)
- [Jinja](https://jinja.palletsprojects.com)

## Customization

- [Color palettes](https://squidfunk.github.io/mkdocs-material/getting-started/#color-palette)
- [Language](https://squidfunk.github.io/mkdocs-material/getting-started/#language)
- [Extending theme](https://squidfunk.github.io/mkdocs-material/customization/#extending-the-theme)

## Text

### Basic effects

|                Code                |       Output       |
| ---------------------------------- | ------------------ |
| `**Bold text**` or `__Bold text__` | **Bold text**      |
| `*Italic text*` or `_Italic text_` | *Italic text*      |
| `~~Strike Through~~`               | ~~Strike Through~~ |
| `==Colored text==`                 | ==Colored text==   |
| <code>\`Inline code\`</code>       | `Inline code`      |

### Hotkeys

|           Code           |         Output         |
| ------------------------ | ---------------------- |
| `++enter++`              | ++enter++              |
| `++"PgDown"++`           | ++"PgDown"++           |
| `++"Non Existent Key"++` | ++"Non Existent Key"++ |


- Unicode: Мислим дакле постојим

## Links, footnotes and comments

### Links

- [I'm an inline-style link](https://www.google.com)
- [I'm an inline-style link with title](https://www.google.com "Google's Homepage")
- [I'm a reference-style link][arbitrary reference text]
- [I'm a relative reference to a repository file](./index)
- [You can use numbers for reference-style link definitions][1]
- You can leave a link empty and use the [link text itself]

**Magic links and emails:** turned to links as recognized

- http://www.google.com
- majkinetor@gmail.com
- www.google.com

### Footnotes

- I am a text with a short footnote[^short]
- I am a text with a long footnote[^long]

### Comments

The text contains 2 comments bellow this line which should not be visible.

[comment]: # (Developed using Visual Studio Code with plantuml extension: cinst visualstudiocode; code --install-extension jebbs.plantuml)
[comment]: # (PlantUML version may influence diagrams. This document is developped with 1.2017.15: cinst plantuml --version 1.2017.15)

[arbitrary reference text]: https://www.mozilla.org
[1]: http://slashdot.org
[link text itself]: http://www.reddit.com

[^short]: https://en.wikipedia.org/wiki/Note_(typography)
[^long]:   
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    massa, nec semper lorem quam in massa.

    ```
    code
    ```

## Citations

> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor  massa, nec semper lorem quam in massa.
> Inline:
> > Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor  massa, nec semper lorem quam in massa.
> ```
> code in citations
> ```
> Another citation line

## HTML

HTML is allowed without restrictions:

<div style='background-color: #fdd; padding:1em; text-align: center '>
    <font size="20">Some big text</font>
</div>

## Critic and comments

Here is some {--*incorrect*--} Markdown.  I am adding this{++ here++}.  Here is some more {--text that I am removing--}text.  And here is even more {++text that I  am ++}adding.
{~~

~>  ~~}Paragraph was deleted and replaced with some spaces.{~~  ~>

~~}Spaces were removed and a paragraph was added.

And here is a comment on {==some text==}{>>This works quite well. I just wanted to comment on it.<<}. Substitutions {~~ is~>are~~} great!

General block handling:

{--

* test remove
* test remove

--}

{++

* test add
* test add

++}


## Emoji

[List of emoji codes](https://web.archive.org/save/https://www.webfx.com/tools/emoji-cheat-sheet/)

- `:tada:` :tada:
- `:jack_o_lantern:` :jack_o_lantern: 
- `:alien:` :alien: 
- `:robot_face:` :robot_face: 
- `:smile:` :smile: 
- `:heart:` :heart: 
- `:thumbsup:` :thumbsup:

:purple_heart: :exclamation: :clock1: :tractor: :chicken: :imp:


## Lists

### Ordered list

1. List item 1
2. List item 2
    1. List item 2.1
    2. List item 2.2
        1. List item 2.2.1
        2. List item 2.2.2
    3. List item 2.3
3. List item 4

### Unordered, mixed

- List item 1
- List item 2
    - List item 2.1
    - List item 2.2
        1. List item 2.2.1
        1. List item 2.2.2
    - List item 2.3
- List item 4

## Tables

|  Col1  |         Col2         |
| ------ | -------------------- |
| row1.1 | row1.2               |
| row2.1 | row2.2-1<br>row2.2-2 |

## Plantuml

Add `plantuml` in a block code header to set code section as PlantUml source. Use `format` to specify output type:

<pre>
``&#x60;plantuml format="svg"
title PlantUml Demo
left to right direction
skinparam packageStyle rectangle
actor customer
actor clerk
rectangle checkout {
  customer -- (checkout)
  (checkout) .> (payment) : include
  (help) .> (checkout) : extends
  (checkout) -- clerk
}
``&#x60;
</pre>

```plantuml format="svg"
title PlantUml Demo
left to right direction
skinparam packageStyle rectangle
actor customer
actor clerk
rectangle checkout {
  customer -- (checkout)
  (checkout) .> (payment) : include
  (help) .> (checkout) : extends
  (checkout) -- clerk
}
```

## MathJax

The block code:

<pre>
``&#x60;
$$
\frac{n!}{k!(n-k)!} = \binom{n}{k}
$$
``&#x60;
</pre>

$$
\frac{n!}{k!(n-k)!} = \binom{n}{k}
$$

---

`Inline math expressions: $p(x|y) = \frac{p(y|x)p(x)}{p(y)}$`

Inline math expressions: $p(x|y) = \frac{p(y|x)p(x)}{p(y)}$

## Admonition

[More info](https://squidfunk.github.io/mkdocs-material/extensions/admonition/)

!!! note
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

??? question "Collapsed closed"
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.    

???+ question "Collapsed open"
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.        

!!! danger "Extreme danger"
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

    ```
    some code
    ```

    > Some citation

## Code Highlight

```python
import tensorflow as tf
```

With tabs:

```bash tab="Bash"
#!/bin/bash

echo "Hello world!"
```

```powershell tab="PowerShell"
"Hello world!"
```

```plantuml tab="UML"
Bob -> Alice : Hello world!
```

```c tab="C"
#include <stdio.h>

int main(void) {
  printf("Hello world!\n");
}
```

```c++ tab="C++"
#include <iostream>

int main() {
  std::cout << "Hello world!" << std::endl;
  return 0;
}
```

```c# tab="C#"
using System;

class Program {
  static void Main(string[] args) {
    Console.WriteLine("Hello world!");
  }
}
```

## Abbreviations

The following are defined in single file, `_inc\abbr.md` and included on each page.

- IT, XML, JSON

## Smart symbols

- `(tm)` (tm)
- `(c)`	(c)
- `c/o`	c/o
- `+/-` +/-
- `-->` -->
- `<--` <--
- `<-->` <-->
- `=/=` =/=
- `1/4` 1/4
- `1st` 1st

## Task list

* [x] Lorem ipsum dolor sit amet, consectetur adipiscing elit
* [x] Curabitur elit nibh, euismod et ullamcorper at, iaculis feugiat est
* [ ] Vestibulum convallis sit amet nisi a tincidunt
    * [x] In hac habitasse platea dictumst
    * [ ] Praesent sed risus massa
* [ ] Nulla vel eros venenatis, imperdiet enim id, faucibus nisi

## Custom span class

Adding custom HTML classes to span elements. 

Syntax: `!!<class names>|<text to be wrapped>!!`.

The following example uses css from the custom_css file, classes `color-yellow` and `backgrond-blue`:

- `I love !!color-yellow background-blue|cookies!!` - I love !!color-yellow background-blue|cookies!!

## Macros

[More details](https://github.com/fralau/mkdocs_macros_plugin#overview).

{% set acme = 'Acme Company Ltd' %}

|                                        |                                                         |
| -------------------------------------- | ------------------------------------------------------- |
| Variable from config                   | `extra.version = {{version}}`                           |
| Variable from this page                | `acme = {{acme}}`                                       |
| Macro (defined in `main.py`)           | `bar(1) = {{ bar(1) }}` - `barbaz(3) = {{ barbaz(3) }}` |
| Python variable (defined in `main.py`) | `baz = {{ baz }}`                                       |
| Dictionary variable from config        | `company.name = {{ company.name }}`                     |

## Jinja templates

You can do all the work you want with Jinja2, including defining pure macros, conditionals and for loops:

<pre>
{&#x25; macro input(name, value='', type='text', size=20) -%}
  &lt;input type="{&#123; type }}" name="{&#123; name }}" value="{&#123; value}}" size="{&#123; size }}">
{&#x25;- endmacro %}

{&#x25; input('username') }}
{&#x25; input('password', type='password') }}
</pre>

## Includes

You may use the include directive from jinja2, directly in your markdown code e.g.:

<pre>
## Paragraph
{&#x25;include 'snippet.md' %}
{&#x25;include 'html/content1.html' %}
</pre>

The root directory for your included files is in `docs_dir`.

## Environment variables

Environment variables can be used inside of configuration file `mkdocs.yaml`.

```
site_name: !!python/object/apply:os.getenv ["CI_PROJECT_PATH"]  
repo_url: !!python/object/apply:os.getenv ["CI_PROJECT_URL"]
repo_name: !!python/object/apply:os.getenv ["CI_PROJECT_PATH"]
```

{% include '_inc/footer.md' %}