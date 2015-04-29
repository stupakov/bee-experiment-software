require 'nokogiri'
require_relative 'csv_renderer'

class XmlToCsvConverter
  def initialize(xml)
    @xml = xml
  end

  def convert_to_csv
    doc = Nokogiri::XML(@xml)

    readings = []

    doc.css('Dataset').each do |node|
      reading = {}
      node.children.each do |datum|
        reading[datum.name] = datum.content
      end

      readings << reading
    end

    Renderers::CsvRenderer.new(readings).render
  end
end
