# frozen_string_literal: true

describe Kril::Producer do
  before { skip 'enable for integration test' }

  avro = AvroTurf::Messaging.new(registry_url: 'http://localhost:8081',
                                 schemas_path: 'spec/schemas/')
  kafka = Kafka.new(%w[localhost:9092 localhost:9093 localhost:9094])

  describe '#send' do
    it 'sends a message' do
      producer = Kril::Producer.new(kafka: kafka, avro: avro)
      producer.send(record: { 'id' => 0 }, schema_name: 'test')
    end
  end
end
