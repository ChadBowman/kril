# frozen_string_literal: true

describe Kril do
  it 'has a version' do
    expect(Kril::VERSION).to_not be_nil
  end

  it 'displays the version' do
    version = `bin/kril --version`
    expect(version.chomp).to eq(Kril::VERSION)
  end

  it 'lists schemas' do
    schemas = `bin/kril --schemas-path spec/resources --list-schemas`
    expect(schemas.split("\n").sort).to eq(%w[complex test])
  end

  it 'produces a record' do
    integration_test
    result = `bin/kril -s human -r '{"age":9}'`
    expect(result.include?('🦐')).to be true
  end

  it 'consumes a record' do
    integration_test
    `bin/kril -s human --synchronous -r '{"age":6}'`
    result = `bin/kril human`
    expect(result.include?('🦐')).to be true
  end

  it 'extracts from a java file and produces a record' do
    integration_test

    Dir.mktmpdir do |temp_dir|
      topic = SecureRandom.uuid
      result = `bin/kril -p #{temp_dir} \
        -j spec/resources -s com.orthus.gdax.schemas.Trade \
        --synchronous -r '{"price":"1","timestamp":9999999,"productId":"BTC-USD"}' \
        #{topic}`
      expect(result.include?('🦐')).to be true
    end
  end
end
