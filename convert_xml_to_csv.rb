#!/usr/bin/env ruby

require 'nokogiri'
require_relative 'lib/csv_renderer'

input_filename = ARGV[0]

unless input_filename.match /\.xml$/
  puts "ERROR: Input file must be an .xml file"
  exit 1
end

output_filename = input_filename.gsub(/xml$/, 'csv')

file = File.read(input_filename)
doc = Nokogiri::XML(file)

readings = []

doc.css('Dataset').each do |node|
    reading = {}
    node.children.each do |datum|
      reading[datum.name] = datum.content
    end

    readings << reading
end

csv_data = Renderers::CsvRenderer.new(readings).render

File.open(output_filename, 'w') do |csv_file|
  csv_file.write(csv_data)
end

puts "\n\n>>> OUTPUT WRITTEN TO #{output_filename}"
