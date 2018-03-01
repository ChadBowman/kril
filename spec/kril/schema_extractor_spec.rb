# frozen_string_literal: true

require 'spec_helper'

describe Kril::SchemaExtractor do
  subject { Kril::SchemaExtractor.new('/Users/cbowman/git/avro-schemas/', 'schemas') }

  describe '#parse_avro_java_class' do
    it 'handles breaks in strings' do
      test_string = <<~JAVA
        SCHEMA$ = parse("{\"name\": \"va","lue,2\"}");
        JAVA
      temp_file(test_string) do |file|
        extraction = subject.send :parse_avro_java_class, file
        expect(extraction).to eq('name' => 'value,2')
      end
    end

    it 'handles litteral quotes' do
      test_string = <<~JAVA
        SCHEMA$ = parse("{"doc":"something like \\\\\\"No Answer\\\\\\" or \\\\\\"Abandoned\\\\\\""}");
        JAVA
      print test_string
      temp_file(test_string) do |file|
        extraction = subject.send :parse_avro_java_class, file
        expected = 'something like "No Answer" or "Abandoned"'
        expect(extraction['doc']).to eq(expected)
      end
    end
  end
end
