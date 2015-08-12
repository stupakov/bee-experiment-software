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
      readings << get_reading_components_from_node(node)
    end

    Renderers::CsvRenderer.new(readings).render
  end

  private

  def get_reading_components_from_node(node)
      reading = {}
      node.children.each do |datum|
        reading[datum.name] = datum.content

        if datum.name == 'UTCTime'
          timestamp_string = datum.content
          reading.merge! make_individual_time_fields(timestamp_string)
        end
      end

      reading
  end

  def make_individual_time_fields(timestamp_string)
    timestamp = DateTime.strptime(timestamp_string, '%m/%d/%Y %H:%M:%S.%N')
    # no timezone info.  assumes time is GMT, though it is actually local time.

    {
      "EpochTime" => timestamp.strftime('%Q'),
      "Year" => timestamp.year,
      "Month" => timestamp.month,
      "Day" => timestamp.day,
      "Hour" => timestamp.strftime('%k'),
      "Minute" => timestamp.minute,
      "Second" => timestamp.second,
      "Millisecond" => timestamp.strftime('%L'),
      "AmPm" => timestamp.strftime('%p')
    }
  end
end
