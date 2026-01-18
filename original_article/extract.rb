#!/usr/bin/env ruby

# extract.rb
# Script to extract software data from the original MediaWiki table in orthodontic-software-list.wiki
# Parses the table rows and creates individual YAML frontmatter files in _software/ for each software entry.
# Run: ruby extract.rb (from project root, assumes orthodontic-software-list.wiki in same dir)

require 'yaml'

# Read the wiki file
content = File.read('orthodontic-software-list.wiki')

# Find the table lines
lines = content.lines

# Find table start (after {| class="wikitable sortable")
table_start = lines.index { |l| l.include?('{| class="wikitable sortable"') }
raise "Table not found" unless table_start

# Skip header rows until data
data_lines = lines[table_start..-1].drop_while { |l| !l.include?('|-') || l.include?('! ') }.drop(1)

# Group into rows (each row ends with |- or |})
rows = []
current_row = []
data_lines.each do |line|
  if line.strip == '|-'
    rows << current_row unless current_row.empty?
    current_row = []
  elsif line.strip.start_with?('| ') && !line.include?('! ')
    current_row << line.strip[2..-1].strip
  end
end
rows << current_row unless current_row.empty?

# Headers from earlier
headers = [
  'developer', 'product', 'version', 'description',
  'dicom_import_filesystem', 'dicom_import_network', 'dicom_import_bulk',
  'dicom_export_filesystem', 'dicom_export_network', 'dicom_export_bulk',
  'dicom_conformance', 'hl7_fhir', 'i14y_friendly', 'updated', 'reference'
]

# Create files
rows.each do |row|
  row += [''] * (headers.size - row.size)
  data = headers.zip(row).to_h
  # Clean filename: remove URLs, special chars
  clean_product = data['product'].gsub(/https?:\/\/[^\s|]+/, '').strip.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s+/, '-').gsub(/^-+|-+$/, '')
  filename = "#{clean_product}.md"
  frontmatter = data.to_yaml
  content = <<~MD
---
#{frontmatter}
---

# #{data['product']}

#{data['description']}
  MD

  File.write("_software/#{filename}", content)
end