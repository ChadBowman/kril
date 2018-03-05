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
    # returns      - schema name, namespace [Hash]
    def process(input_string)
      if File.exist?(input_string)
        copy_schema_to_store(input_string)
      elsif schema?(input_string)
        save_schema(input_string)
      else
        name, namespace = separate_fullname(input_string)
        namespace = nil if namespace.empty?
        schema = @schema_store.find(name, namespace)
        {
          schema_name: schema&.name,
          namespace: schema&.namespace
        }
      end
    end

    private

    def separate_fullname(fullname)
      arr = fullname.split('.')
      [arr.pop, arr.join('.')]
    end

    def schema?(input)
      !JSON.parse(input)['name'].nil?
    rescue StandardError
      false
    end

    def save_schema(schema)
      schema = JSON.parse(schema)
      schema_name = schema['name']
      namespace = schema['namespace']
      if namespace
        path = File.join(@schemas_path, namespace.split('.'))
        FileUtils.mkdir_p(path)
      end
      File.open(File.join(path || @schemas_path, "#{schema_name}.avsc"), 'w') do |file|
        file.write(JSON.pretty_generate(schema))
      end
      {
        schema_name: schema_name,
        namespace: namespace
      }
    end

    def copy_schema_to_store(path)
      schema = File.read(path)
      raise ArgumentError, "Not a valid schema: #{path}" unless schema?(schema)
      json = JSON.parse(schema)
      schema_name = json['name']
      namespace = json['namespace']
      if namespace
        schema_path = File.join(@schemas_path, namespace.split('.'))
        FileUtils.mkdir_p(schema_path)
      end
      FileUtils.copy_file(path, File.join(schema_path || @schemas_path, "#{schema_name}.avsc"))
      {
        schema_name: schema_name,
        namespace: namespace
      }
    end
  end
end
