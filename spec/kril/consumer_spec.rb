# frozen_string_literal: true

describe Kril::Consumer  do
  before { integration_test }

  avro = AvroTurf::Messaging.new(registry_url: 'http://localhost:8081',
                                 schemas_path: 'spec/resources/')
  kafka = Kafka.new(%w[localhost:9092 localhost:9093 localhost:9094])

  describe '#consume_one' do
    it 'consumes a message' do
      producer = Kril::Producer.new(kafka: kafka, avro: avro)
      subject = Kril::Consumer.new(kafka: kafka, avro: avro)

      topic = SecureRandom.uuid
      producer.send(record: { 'id' => 99 },
                    schema_name: 'test',
                    topic: topic,
                    syncronous: true)
      result = subject.consume_one(topic)
      expect(result[:value]['id']).to eq(99)
    end
  end

  describe '#consume_all' do
    it 'consumes a all past records' do
      producer = Kril::Producer.new(kafka: kafka, avro: avro)
      subject = Kril::Consumer.new(kafka: kafka, avro: avro)

      topic = SecureRandom.uuid
      producer.send(record: { 'id' => 0 }, schema_name: 'test', topic: topic)
      producer.send(record: { 'id' => 1 }, schema_name: 'test', topic: topic)
      producer.send(record: { 'id' => 2 }, schema_name: 'test', topic: topic)

      count = 0
      subject.consume_all(topic) do |message, consumer|
        count += 1
        expect([0, 1, 2]).to include(message[:value]['id'])
        consumer.stop if count > 2
      end
    end
  end
end
