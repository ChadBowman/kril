# frozen_string_literal: true

module Kril
  # Creates and validates a record based from a defined schema.
  class RecordBuilder
    def initialize(schema_file_name: nil,
                   schemas_dir: 'schemas/',
                   schema_path: nil)
      path = schema_path || File.join(schemas_dir, "#{schema_file_name}.avsc")
      file = File.read(path)
      @schema = JSON.parse(file)
    end

    def build(data)
      data = JSON.parse(data)
      build_from_record(@schema, data)
    end

    private

    def build_from_record(schema, data)
      schema['fields'].each_with_object({}) do |field, record|
        field_name = field['name']
        record[field_name] =
          case field['type']
          when 'array'
            build_from_array(field, data[field_name])
          when 'map'
            build_from_map(field, data[field_name])
          when 'record'
            build_from_record(field, data[field_name])
          else
            build_field(field, data[field_name])
          end
      end
    end

    def build_from_array(field, data)
      data.map { |element| build_field(field, element) }
    end

    def build_from_map(field, data)
      data.transform_values { |element| build_field(field, element) }
    end

    def build_field(field, datum)
      check_nullity(datum, field)
      type = field['items'] || field['values'] || field['type']
      convert_type(datum, type)
    end

    def check_nullity(datum, field)
      type = field['values'] || field['items'] || field['type']
      unless datum || type&.include?('null')
        raise ArgumentError.new, "Input for #{field['name']} cannot be nil"
      end
    end

    def convert_type(datum, type)
      type = gather_types(type)
      if datum.nil?
        nil
      elsif type.include?('int') || type.include?('long')
        datum.to_i
      elsif type.include?('float') || type.include?('double')
        datum.to_f
      elsif type.include?('boolean')
        datum.casecmp('true').zero?
      else
        datum
      end
    end

    def gather_types(type)
      case type
      when String
        type
      when Array
        type.flat_map { |t| gather_types(t) }
      when Hash
        gather_types(type['type'])
      end
    end
  end
end
