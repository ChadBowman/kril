# frozen_string_literal: true

module Kril
  # Consumers records from Kafka
  class Consumer
    def initialize(avro: nil, kafka: nil, config: {})
      config[:group_id] ||= '🦐'
      @avro = avro
      @kafka = kafka
      @config = config
    end

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

    def listen(topic)
      consumer = build_consumer(topic, false, @config)
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
