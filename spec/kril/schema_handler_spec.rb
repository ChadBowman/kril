# frozen_string_literal: true

describe Kril::SchemaHandler do
  schemas_path = 'spec/schemas/'
  subject { Kril::SchemaHandler.new(schemas_path: schemas_path) }
  schema = '{"type":"record","name":"temp","fields":[]}'

  describe '#process' do
    it 'handles a schema path' do
      temp_file(schema) do |file|
        name = subject.process(file.path)
        path = "#{schemas_path}#{name}.avsc"
        expect(File.exist?(path)).to be true
        File.delete(path)
      end
    end

    it 'handles schema contents' do
      name = subject.process(schema)
      path = "#{schemas_path}#{name}.avsc"
      expect(File.exist?(path)).to be true
      File.delete(path)
    end

    it 'handles a schema name' do
      name = subject.process('test')
      expect(name).to eq('test')
    end

    it 'errors if no schema found' do
      expect { subject.process('doesntexist') }.to raise_error(AvroTurf::SchemaNotFoundError)
    end
  end
end
