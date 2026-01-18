#!/usr/bin/env python3

import os
import yaml
from jinja2 import Environment, FileSystemLoader

# Setup Jinja2
env = Environment(loader=FileSystemLoader('templates'))

# Site context
site_context = {
    'site_title': 'Orthodontic Software List',
    'site_description': 'A list of medical software or devices designed for orthodontic data, focusing on interoperability levels.',
    'build_date': '2025-01-18'  # Update dynamically if needed
}

# Load software data
software_list = []
software_dir = '_software'
for filename in os.listdir(software_dir):
    if filename.endswith('.md'):
        with open(os.path.join(software_dir, filename), 'r') as f:
            lines = f.readlines()
            if lines[0].strip() == '---':
                # Find end of frontmatter
                yaml_start = 2
                end_idx = lines[yaml_start:].index('---\n') + yaml_start
                frontmatter_text = ''.join(lines[yaml_start:end_idx])
                frontmatter = yaml.safe_load(frontmatter_text)
                if frontmatter:
                    frontmatter['filename'] = filename.replace('.md', '.html')
                    software_list.append(frontmatter)

# Sort by product name
software_list.sort(key=lambda x: x['product'])

# Render style.css
template = env.get_template('style.css.j2')
output = template.render(**site_context)
os.makedirs('_site', exist_ok=True)
with open('_site/style.css', 'w') as f:
    f.write(output)

# Render index.html
template = env.get_template('index.html.j2')
output = template.render(software_list=software_list, css_path="", **site_context)
with open('_site/index.html', 'w') as f:
    f.write(output)

# Render software pages
template = env.get_template('software.html.j2')
for software in software_list:
    output = template.render(software=software, css_path="../", **site_context)
    os.makedirs('_site/software', exist_ok=True)
    with open(f'_site/software/{software["filename"]}', 'w') as f:
        f.write(output)

# Render wiki.wiki
template = env.get_template('wiki.wiki.j2')
output = template.render(software_list=software_list, **site_context)
with open('wikipediaarticle.wiki', 'w') as f:
    f.write(output)

print("Build complete!")