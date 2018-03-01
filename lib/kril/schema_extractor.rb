# frozen_string_literal: true

module Kril
  # Extracts avro schemas from avro genrated java files.
  class SchemaExtractor
    def initialize(source_dir, output_dir)
      @source_dir = source_dir
      @output_dir = output_dir
    end

    def extract
      find_java_files(@source_dir) do |file|
        schema = parse_avro_java_class(file)
        write_avsc(schema, @output_dir) if schema
      end
    end

    private

    def find_java_files(root_dir)
      old_dir = Dir.pwd
      Dir.chdir(root_dir)
      java_files = File.join('**', '*.java')
      Dir.glob(java_files) do |file|
        yield File.new(file)
      end
      Dir.chdir(old_dir)
    end

    def write_avsc(contents, directory)
      file_name = File.join(directory, "#{contents['name']}.avsc")
      File.open(file_name, 'w') do |file|
        file.write(JSON.pretty_generate(contents))
      end
    end

    def dejavafy(java_string)
      java_string.split('","').join.gsub(/\\?\\"/, '"')
    end

    def parse_avro_java_class(file)
      file.each_line do |line|
        extraction = line[/SCHEMA.*parse\("(.*)"\);/, 1]
        normalised = dejavafy(extraction)
        break JSON.parse(normalised) if extraction
        nil
      end
    end
  end
end
