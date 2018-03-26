# frozen_string_literal: true

describe Kril::SchemaExtractor do
  subject { Kril::SchemaExtractor }

  describe '#parse_avro_java_class' do
    it 'handles breaks in strings' do
      test_string = <<~JAVA
        SCHEMA$ = parse("{\"name\": \"va","lue,2\"}");
        JAVA
      temp_file(test_string) do |file|
        extraction = JSON.parse(subject.send :parse_avro_java_class, file)
        expect(extraction).to eq('name' => 'value,2')
      end
    end

    it 'handles literal quotes' do
      test_string = <<~JAVA
        SCHEMA$ = parse("{"doc":"something like \\\\\\"No Answer\\\\\\" or \\\\\\"Abandoned\\\\\\""}");
        JAVA
      temp_file(test_string) do |file|
        extraction = JSON.parse(subject.send :parse_avro_java_class, file)
        expected = 'something like "No Answer" or "Abandoned"'
        expect(extraction['doc']).to eq(expected)
      end
    end
  end

  describe '#extract' do
    it 'extracts from Avro generated java files' do
      schema_dir = File.join(Dir.pwd, 'spec', 'resources')
      Kril::SchemaExtractor.extract(source_dir: schema_dir,
                                    output_dir: schema_dir)
      path = File.join(schema_dir, 'com', 'orthus', 'gdax', 'schemas', 'Trade.avsc')
      expect(File.exist?(path)).to be true

      schema = JSON.parse(File.read(path))
      expect(schema['type']).to eq('record')
      expect(schema['name']).to eq('Trade')
      expect(schema['fields'].size).to eq(3)

      field = schema['fields'].first
      expect(field['name']).to eq('price')
      expect(field['type']['type']).to eq('string')

      FileUtils.rm_r(File.join(schema_dir, 'com'))
    end
  end
end
