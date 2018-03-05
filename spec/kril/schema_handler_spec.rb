# frozen_string_literal: true

describe Kril::SchemaHandler do
  schemas_path = 'spec/resources/'
  subject { Kril::SchemaHandler.new(schemas_path: schemas_path) }
  schema = '{"type":"record","name":"temp","fields":[]}'

  describe '#process' do
    it 'handles a schema path' do
      temp_file(schema) do |file|
        name = subject.process(file.path)[:schema_name]
        path = "#{schemas_path}#{name}.avsc"
        expect(File.exist?(path)).to be true
        File.delete(path)
      end
    end

    it 'handles schema contents' do
      name = subject.process(schema)[:schema_name]
      path = "#{schemas_path}#{name}.avsc"
      expect(File.exist?(path)).to be true
      File.delete(path)
    end

    it 'handles a schema name' do
      name = subject.process('test')[:schema_name]
      expect(name).to eq('test')
    end

    it 'errors if no schema found' do
      expect { subject.process('doesntexist') }.to raise_error(AvroTurf::SchemaNotFoundError)
    end

    it 'handles a complex schema' do
      schema = subject.process('spec/resources/complex.avsc')
      path = File.join(schemas_path, schema[:namespace].split('.'), "#{schema[:schema_name]}.avsc")
      expect(File.exist?(path)).to be true
      FileUtils.rm_r(File.join(schemas_path, 'net'))
    end

    it 'handles colliding schema name' do
      schema1 = '{"type":"record","name":"temp","namespace":"one"}'
      schema2 = '{"type":"record","name":"temp","namespace":"two"}'
      result1 = subject.process(schema1)
      result2 = subject.process(schema2)
      path1 = File.join(schemas_path, result1[:namespace].split('.'), "#{result1[:schema_name]}.avsc")
      path2 = File.join(schemas_path, result2[:namespace].split('.'), "#{result2[:schema_name]}.avsc")

      expect(path1).to eq("#{schemas_path}one/temp.avsc")
      expect(path2).to eq("#{schemas_path}two/temp.avsc")
      expect(File.exist?(path1)).to be true
      expect(File.exist?(path2)).to be true

      FileUtils.rm_r(File.join(schemas_path, result1[:namespace].split('.').first))
      FileUtils.rm_r(File.join(schemas_path, result2[:namespace].split('.').first))
    end
  end

  describe '#schema?' do
    it 'is false when schema has no name' do
      result = subject.send :schema?, '{"type":"record","fields":[]}'
      expect(result).to be false
    end
  end

  describe '#separate_fullname' do
    it 'separates a fullname' do
      result = subject.send :separate_fullname, 'net.orthus.schema.Schema'
      expect(result.first).to eq('Schema')
      expect(result.last).to eq('net.orthus.schema')
    end
  end
end
