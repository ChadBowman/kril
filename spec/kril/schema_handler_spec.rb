# frozen_string_literal: true

describe Kril::SchemaHandler do
  schemas_path = 'spec/resources/'
  subject { Kril::SchemaHandler.new(schemas_path: schemas_path) }
  schema = '{"type":"record","name":"temp","fields":[]}'

  describe '#process' do
    it 'handles a schema path' do
      temp_file(schema) do |file|
        subject.process(file.path)
        path = "#{schemas_path}temp.avsc"
        expect(File.exist?(path)).to be true
        File.delete(path)
      end
    end

    it 'handles schema contents' do
      subject.process(schema)
      path = "#{schemas_path}temp.avsc"
      expect(File.exist?(path)).to be true
      File.delete(path)
    end

    it 'handles a schema name' do
      schema = subject.process('test')
      expect(schema).to_not be nil
    end

    it 'errors if no schema found' do
      expect { subject.process('doesntexist') }.to raise_error(AvroTurf::SchemaNotFoundError)
    end

    it 'handles a complex schema' do
      schema = subject.process('spec/resources/complex.avsc')
      p path = File.join(schemas_path, 'net', 'orthus', 'schemas')
      expect(File.exist?(path)).to be true
      FileUtils.rm_r(File.join(schemas_path, 'net'))
    end

    it 'handles colliding schema name' do
      schema1 = '{"type":"record","name":"temp","namespace":"one","fields":[]}'
      schema2 = '{"type":"record","name":"temp","namespace":"two","fields":[]}'

      subject.process(schema1)
      subject.process(schema2)

      path1 = File.join(schemas_path, 'one', 'temp.avsc')
      path2 = File.join(schemas_path, 'two', 'temp.avsc')

      expect(File.exist?(path1)).to be true
      expect(File.exist?(path2)).to be true

      FileUtils.rm_r(File.join(schemas_path, 'one'))
      FileUtils.rm_r(File.join(schemas_path, 'two'))
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
