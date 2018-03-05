# frozen_string_literal: true

module Kril
  # Extracts schemas from avro generated java files.
  module SchemaExtractor
    # Parse schemas from avro generated java files and
    # load them into the schema repository.
    #
    # source_dir - root directory of java files [String]
    # output_dir - schema repository [String]
    # returns    - [nil]
    def self.extract(source_dir:, output_dir:)
      find_java_files(source_dir) do |file|
        schema = parse_avro_java_class(file)
        write_avsc(schema, output_dir) if schema
      end
      nil
    end

    module_function

    def find_java_files(root_dir)
      old_dir = Dir.pwd
      Dir.chdir(root_dir)
      java_files = File.join('**', '*.java')
      Dir.glob(java_files) do |file|
        yield File.new(file)
      end
    ensure
      Dir.chdir(old_dir)
    end

    def write_avsc(contents, directory)
      path = File.join(directory, "#{contents['name']}.avsc")
      File.open(path, 'w') do |file|
        file.write(JSON.pretty_generate(contents))
      end
    end

    def dejavafy(java_string)
      java_string.split('","').join.gsub(/\\?\\"/, '"')
    end

    def parse_avro_java_class(file)
      result = file.each_line do |line|
        extraction = line[/SCHEMA.*parse\("(.*)"\);/, 1]
        break JSON.parse(dejavafy(extraction)) if extraction
      end
      result.is_a?(File) ? nil : result
    end
  end
end
