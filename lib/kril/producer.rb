# frozen_string_literal: true

module Kril
  # Produces records to Kafka
  class Producer
    def initialize(avro: nil, kafka: nil, config: {})
      config[:required_acks] ||= 1
      config[:delivery_threshold] ||= 1
      sync_config = config.dup
      @avro = avro
      @async = kafka.async_producer(config)
      sync_config.delete(:delivery_threshold)
      @sync = kafka.producer(sync_config)
    end

    def send(record:, schema_name:, topic: nil, syncronous: false)
      topic ||= schema_name
      encoded = @avro.encode(record, schema_name: schema_name)
      if syncronous
        @producer.produce(encoded, topic: topic)
        @producer.deliver_messages
      else
        @async.produce(encoded, topic: topic)
      end
    ensure
      @async.shutdown
      @sync.shutdown
    end
  end
end
