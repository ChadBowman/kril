# frozen_string_literal: true

module Kril
  # High level abstraction for consuming records from topics.
  class Consumer
    # avro   - Avro instance for deserializing records [AvroTurf::Messaging]
    # kafka  - Kafka instance for creating consumers [Kafka]
    # config - consumer configuration (optional) [Hash]
    def initialize(avro: nil, kafka: nil, config: {})
      config[:group_id] ||= 'kril-consumer'
      @avro = avro
      @kafka = kafka
      @config = config
    end

    # Consume a single record from any partition.
    # Will block indefinitely if no record present.
    #
    # topic  - topic to consume from [String]
    # return - deserialized record [String]
    def consume_one(topic)
      consumer = build_consumer(topic, true, @config)
      msg = nil
      consumer.each_message do |message|
        msg = decode(message)
        consumer.mark_message_as_processed(message)
        consumer.commit_offsets
        consumer.stop
      end
      msg
    ensure
      consumer.stop
    end

    # Consume all records from a topic. Each record will be yielded
    # to block along with consumer instance. Will listen to topic
    # after all records have been consumed.
    #
    # topic  - topic to consume from [String]
    # yields - record, consumer [String, Kafka::Consumer]
    # return - [nil]
    def consume_all(topic)
      config = @config.clone
      config[:group_id] = SecureRandom.uuid
      consumer = build_consumer(topic, true, config)
      consumer.each_message do |message|
        yield decode(message), consumer
      end
    ensure
      consumer.stop
    end

    private

    def build_consumer(topic, start_from_beginning, config)
      consumer = @kafka.consumer(config)
      consumer.subscribe(topic, start_from_beginning: start_from_beginning)
      consumer
    end

    def decode(message)
      {
        key: message.key,
        value: @avro.decode(message.value),
        offset: message.offset,
        create_time: message.create_time,
        topic: message.topic,
        partition: message.partition
      }
    end
  end
end
