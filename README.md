# Orthodontic Software List

A list of medical software or devices which are designed to be used with orthodontic data and collect or manipulate data that could be of interest to another software. This list focuses on the level of interoperability (the ability for the software to be able to connect with another software) that a specific software or device has.

## Overview

This repository maintains a structured list of orthodontic software products, their features, and interoperability levels. Data is stored in human-readable YAML format, and the system generates:

- **HTML Website**: A multipage site hosted on GitHub Pages for easy browsing.
- **MediaWiki File**: A single file ready for upload to Wikipedia.

Each software entry is stored in its own file in the `_software/` directory.

## Prerequisites

- **Nix**: For managing the development environment. Install from [nixos.org](https://nixos.org/download.html).
- Alternatively, ensure Python 3, Jinja2, PyYAML, and Pandoc are installed manually.

## Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/orthodontic-software-list.git
   cd orthodontic-software-list
   ```

2. Enter the Nix shell (recommended):
   ```bash
   nix-shell
   ```
   This provides all necessary dependencies.

## Usage

### Building the Site and Wiki

Run the build script to generate HTML and MediaWiki outputs:
```bash
python build.py
```

- **HTML Output**: Generated in `_site/` (multipage site).
- **Wiki Output**: `wikipediaarticle.wiki` (single file for Wikipedia).

### Adding or Editing Software

1. Create or edit a file in `_software/` (e.g., `newsoftware.md`).
2. Use YAML frontmatter for structured data:

   ```yaml
   ---
   developer: "Company Name"
   product: "Software Name"
   version: ""
   description: "Brief description of the software."
   dicom_import_filesystem: "Yes"
   dicom_import_network: "No"
   dicom_import_bulk: "Partial"
   dicom_export_filesystem: "Yes"
   dicom_export_network: "Yes (DIMSE)"
   dicom_export_bulk: "No"
   dicom_conformance: "Available at URL"
   hl7_fhir: "FHIR: Encounter, Appointments"
   i14y_friendly: "Yes"
   updated: "2025-01-18"
   reference: "Company website"
   ---

   # Software Name

   Additional markdown content if needed.
   ```

3. Rebuild with `python build.py`.

### Deploying

- **GitHub Pages**: Automatic deployment via GitHub Actions (pushes to `gh-pages` branch on pushes to `main`).
- **Wikipedia**: Upload `wikipediaarticle.wiki` to the relevant Wikipedia page.

## Project Structure

- `_software/`: YAML data files (one per software).
- `templates/`: Jinja2 templates for HTML and Wiki generation.
- `build.py`: Main build script.
- `shell.nix`: Nix environment configuration.
- `_site/`: Generated HTML site (not committed).
- `wikipediaarticle.wiki`: Generated Wiki file.

## Contributing

1. Fork the repository.
2. Add or update software data in `_software/`.
3. Run `python build.py` and test outputs.
4. Submit a pull request.

For questions, open an issue on GitHub.
