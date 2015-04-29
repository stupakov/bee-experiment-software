#!/usr/bin/env ruby

require_relative 'lib/xml_to_csv_converter'

input_filename = ARGV[0]

unless input_filename.match /\.xml$/
  abort "ERROR: Input file must be an .xml file"
end

output_filename = input_filename.gsub(/xml$/, 'csv')

input_file_contents = File.read(input_filename)

csv_data = XmlToCsvConverter.new(input_file_contents).convert_to_csv

File.open(output_filename, 'w') do |csv_file|
  csv_file.write(csv_data)
end

puts "\n\n>>> OUTPUT WRITTEN TO #{output_filename}"
