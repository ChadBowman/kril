# frozen_string_literal: true

describe Kril::RecordBuilder do
  describe '#build_from_record' do
    BASIC_SCHEMA = <<~AVSC
      {
        "name": "basic",
        "type": "record",
        "fields": [
          {
            "name": "name",
            "type": "string"
          },
          {
            "name": "age",
            "type": "long"
          }
        ]
      }
      AVSC

    it 'builds a simple record' do
      temp_file(BASIC_SCHEMA) do |file|
        data = '{"name": "chad", "age": "27"}'
        result = Kril::RecordBuilder.new(schema_path: file.path).build(data)
        expect(result['name']).to eq('chad')
        expect(result['age']).to eq(27)
      end
    end

    it 'errors from a missing field' do
      temp_file(BASIC_SCHEMA) do |file|
        data = '{"name": "chad"}'
        subject = Kril::RecordBuilder.new(schema_path: file.path)
        expect { subject.build(data) }.to raise_error(ArgumentError)
      end
    end

    NULLABLE_SCHEMA = <<~AVSC
      {
        "name": "nullable",
        "type": "record",
        "fields": [
          {
            "name": "value",
            "type": ["null", "long"]
          }
        ]
      }
      AVSC

    it 'builds from a nullable field' do
      temp_file(NULLABLE_SCHEMA) do |file|
        data = '{"value": "5"}'
        result = Kril::RecordBuilder.new(schema_path: file.path).build(data)
        expect(result['value']).to eq(5)
      end
    end

    it 'builds from a null value' do
      temp_file(NULLABLE_SCHEMA) do |file|
        data = '{}'
        result = Kril::RecordBuilder.new(schema_path: file.path).build(data)
        expect(result['value']).to be_nil
      end
    end
  end

  describe '#build_from_array' do
    ARRAY_SCHEMA = <<~AVSC
      {
        "name": "arrayish",
        "type": "record",
        "fields": [
          {
            "name": "values",
            "type": "array",
            "items": "int"
          }
        ]
      }
      AVSC

    it 'builds from a simple array' do
      temp_file(ARRAY_SCHEMA) do |file|
        data = '{"values": ["1", "2", "3"]}'
        result = Kril::RecordBuilder.new(schema_path: file.path).build(data)
        expect(result['values']).to eq([1, 2, 3])
      end
    end
  end

  describe '#build_from_map' do
    MAP_SCHEMA = <<~AVSC
      {
        "name": "mapish",
        "type": "record",
        "fields": [
          {
            "name": "values",
            "type": "map",
            "values": "boolean"
          }
        ]
      }
      AVSC

    it 'builds from a simple map' do
      temp_file(MAP_SCHEMA) do |file|
        data = '{"values": {"is true": "true", "is false": "false"}}'
        result = Kril::RecordBuilder.new(schema_path: file.path).build(data)
        expect(result['values']['is true']).to be true
        expect(result['values']['is false']).to be false
      end
    end
  end

  describe '#build' do
    it 'builds from a nested record' do
      NESTED_SCHEMA = <<~AVSC
        {
          "name": "nested",
          "type": "record",
          "fields": [
            {
              "name": "Address",
              "type": "record",
              "fields": [
                {
                  "name": "apartment number",
                  "type": [
                    "null",
                    {
                      "type": "int",
                      "avro.java.integer": "Integer"
                    }
                  ]
                }
              ]
            }
          ]
        }
        AVSC

      temp_file(NESTED_SCHEMA) do |file|
        data = '{"Address": {"apartment number": "204"}}'
        result = Kril::RecordBuilder.new(schema_path: file.path).build(data)
        expect(result['Address']['apartment number']).to eq(204)
      end
    end
  end
end
