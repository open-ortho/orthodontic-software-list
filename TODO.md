# TODO

## Project Overview
Transform the current wikipediaarticle.wiki into a maintainable Jekyll site using YAML data, generating:
- Multipage HTML for GitHub Pages (one page per software + index).
- Single-page MediaWiki .wiki file for Wikipedia.

Each software entry from the table will be in its own Markdown file with YAML frontmatter.

## Detailed Plan
- **Environment Setup**: Use Nix shell (`shell.nix`) for dependencies (Python, Pandoc).
- **Build Script**: Python script with Jinja2 for templating HTML and MediaWiki.
- **Data Structure**: `_software/` folder with YAML files (one per software, containing data like developer, product, description, DICOM fields, etc.).
- **HTML Generation**: Script generates multipage site in `_site/`: index.html lists all, software/name.html for details.
- **MediaWiki Generation**: Script generates single `wikipediaarticle.wiki` with table aggregating all entries.
- **Extraction**: Parse existing wiki table, create separate YAML files for each row.
- **Build & Deploy**: Run `python build.py`; outputs to `_site/` and root. Deploy `_site/` via GitHub Pages.
- **Testing**: Verify HTML renders table correctly, wiki file matches original structure.

## Progress Tracking
- [x] Set up Nix shell (`shell.nix`)
- [x] Switch to Python + Jinja2 build script
- [x] Create `_software/` directory with YAML files
- [x] Extract data from wiki table to YAML files (original files moved to original_article/)
- [x] Create build.py script for HTML and MediaWiki generation
- [x] Set up Jinja2 templates for HTML and wiki
- [x] Add custom CSS and Jinja layouts/includes for pretty pages
- [x] Build and test outputs (wiki output to gitignored output/ folder)
- [x] Create empty gh-pages branch for GitHub Pages deployment
- [ ] Finalize wiki file for upload
