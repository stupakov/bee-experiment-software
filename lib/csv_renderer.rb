require 'csv'

module Renderers
  class CsvRenderer

    def csv_fields
      %w|UTCTime ReaderID UID ScanCount Type Address text|
    end

    CSV_COLSEP = ";"
    CSV_ROWSEP = "\r\n"

    attr_writer :data

    def initialize(arg)
      @data = arg
    end

    def render
      return "" if no_data?
      ::CSV.generate(:col_sep => CSV_COLSEP,
                     :row_sep => CSV_ROWSEP
                    ) do |csv|
        render_header(csv)
        render_data(csv)
      end
    end

    private

    def no_data?
      @data.nil?
    end

    def render_header(csv)
      csv << csv_fields
    end

    def render_data(csv)
      @data.each do |item|
        csv << render_item(item)
      end
    end

    def render_item(item)
      csv_fields.map do |m|
        item[m].to_s.
        gsub(/\r\n/, " ").
        gsub(/\n/, " ").
        gsub(/;/, ",")
      end
    end
  end
end

