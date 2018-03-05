# frozen_string_literal: true

module Kril
  # High level abstraction for producing records to topics.
  class Producer
    # avro   - Avro instance for deserializing records [AvroTurf::Messaging]
    # kafka  - Kafka instance for creating producers [Kafka]
    # config - producer configuration (optional) [Hash]
    def initialize(avro: nil, kafka: nil, config: {})
      config[:required_acks] ||= 1
      config[:delivery_threshold] ||= 1
      sync_config = config.dup
      @avro = avro
      @async = kafka.async_producer(config)
      sync_config.delete(:delivery_threshold)
      @sync = kafka.producer(sync_config)
    end

    # Commit a record to a topic.
    #
    # record       - record to serialize and commit [String]
    # schema_name  - name of schema to encode record from [String]
    # topic        - name of topic. Will be schema_name if nil (optional) [String]
    # synchronous  - blocks until commit if true (optional) [Boolean]
    def send(record:, schema_name:, topic: nil, syncronous: false)
      topic ||= schema_name
      encoded = @avro.encode(record, schema_name: schema_name)
      if syncronous
        @sync.produce(encoded, topic: topic)
        @sync.deliver_messages
      else
        @async.produce(encoded, topic: topic)
      end
    ensure
      @async.shutdown
      @sync.shutdown
    end
  end
end
