# frozen_string_literal: true

module Kril
  # Saves schemas to repository.
  class SchemaHandler
    # schemas_path - directory of schema repository [String]
    # schema_store - schema store [AvroTurf::SchemaStore]
    def initialize(schemas_path:,
                   schema_store: nil)
      schema_store ||= AvroTurf::SchemaStore.new(path: schemas_path)
      @schema_store = schema_store
      @schemas_path = schemas_path
    end

    # Handles input to reference or create schema.
    #
    # input_string - schema name, schema file, or schema contents [String]
    # returns      - stored schema [Avro::Schema]
    def process(input_string)
      name, namespace =
        if File.exist?(input_string)
          copy_schema_to_store(input_string)
        elsif schema?(input_string)
          save_schema(input_string)
        else
          separate_fullname(input_string)
        end
      @schema_store.find(name, namespace)
    end

    private

    def separate_fullname(fullname)
      arr = fullname.split('.')
      name = arr.pop
      namespace = arr.join('.')
      namespace = nil if namespace.empty?
      [name, namespace]
    end

    def schema?(input)
      !JSON.parse(input)['name'].nil?
    rescue StandardError
      false
    end

    def build_path(name, namespace)
      base = namespace ? File.join(@schemas_path, namespace.split('.')) : @schemas_path
      File.join(base, "#{name}.avsc")
    end

    def save_schema(schema)
      schema = JSON.parse(schema)
      path = build_path(schema['name'], schema['namespace'])
      FileUtils.mkdir_p(File.dirname(path))
      File.open(path, 'w') do |file|
        file.write(JSON.pretty_generate(schema))
      end
      [schema['name'], schema['namespace']]
    end

    def copy_schema_to_store(path)
      schema = File.read(path)
      raise ArgumentError, "Not a valid schema: #{path}" unless schema?(schema)
      save_schema(schema)
    end
  end
end
