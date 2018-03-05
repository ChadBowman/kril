# frozen_string_literal: true

module Kril
  # Saves schemas to repository.
  class SchemaHandler
    # schemas_path - directory of schema repository [String]
    # schema_store - schema store [AvroTurf::SchemaStore]
    def initialize(schemas_path: 'schemas/',
                   schema_store: nil)
      schema_store ||= AvroTurf::SchemaStore.new(path: schemas_path)
      @schema_store = schema_store
      @schemas_path = schemas_path
    end

    # Handles input to reference or create schema.
    #
    # input_string - schema name, schema file, or schema contents [String]
    # returns      - schema name [String]
    def process(input_string)
      if File.exist?(input_string)
        copy_schema_to_store(input_string)
      elsif schema?(input_string)
        save_schema(input_string)
      else
        @schema_store.find(input_string).name
      end
    end

    private

    def schema?(input)
      JSON.parse(input)['name']
    rescue StandardError
      false
    end

    def save_schema(schema)
      schema = JSON.parse(schema)
      schema_name = schema['name']
      path = File.join(@schemas_path, "#{schema_name}.avsc")
      File.open(path, 'w') { |file| file.write(JSON.pretty_generate(schema)) }
      schema_name
    end

    def copy_schema_to_store(path)
      schema = File.read(path)
      raise ArgumentError.new, "Not a valid schema: #{path}" unless schema?(schema)
      schema_name = JSON.parse(schema)['name']
      new_path = File.join(@schemas_path, "#{schema_name}.avsc")
      FileUtils.copy_file(path, new_path)
      schema_name
    end
  end
end
