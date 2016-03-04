require 'json'

module Embulk
  module Formatter

    class Geojson < FormatterPlugin
      Plugin.register_formatter("geojson", self)

      def self.transaction(config, schema, &control)
        # configuration code:
        task = {
          "template_file" => config.param("template_file", :string), # required
          "encoding" => config.param("encoding", :string, default: 'UTF-8'),
          "identifier" => config.param("identifier", :string, default: 'id')
        }

        yield(task)
      end

      def init
        # initialization code:
        @template_file = task['template_file']
        @encoding = task['encoding']
        @identifier = task['identifier']

        @template_json = JSON.parse(File.read(@template_file))
        @features = @template_json["features"]
        # your data
        @current_file == nil
        @current_file_size = 0

        @is_first_row = true
      end

      def close
      end

      def add(page)
        # output code:
        page.each do |record|
          if @current_file == nil
            @current_file = file_output.next_file
            @current_file.write '{"type": "FeatureCollection", "features": ['.encode(@encoding)
            @current_file_size = 0
            @is_first_row = true
          elsif @current_file_size > 32 * 1024 * 1024
            @current_file.write ']}'.encode(@encoding)
            @current_file = file_output.next_file
            @current_file.write '{"type": "FeatureCollection", "features": ['.encode(@encoding)
            @current_file_size = 0
            @is_first_row = true
          end

          schema = page.schema.map { |s| s.name }
          record_hash = Hash[schema.zip record]

          feature = @features.select do |f|
            f["properties"][@identifier].to_s == record_hash[@identifier]
          end

          raise "Invalid identifier" unless feature.length <= 1

          if feature.length == 1
            if @is_first_row
              @is_first_row = false
            else
              @current_file.write ','.encode(@encoding)
            end
            feature[0]["properties"] = feature[0]["properties"].merge(record_hash)
            @current_file.write JSON.dump(feature[0]).encode(@encoding)
          end
        end
      end

      def finish
        if @current_file != nil
          @current_file.write ']}'.encode(@encoding)
        end
        file_output.finish
      end
    end

  end
end
