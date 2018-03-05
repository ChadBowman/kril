# frozen_string_literal: true

require 'kril/version'
require 'kril/record_builder'
require 'kril/schema_extractor'
require 'kril/schema_handler'
require 'kril/producer'
require 'kril/consumer'
require 'json'
require 'yaml'
require 'logger'
require 'avro_turf/messaging'
require 'kafka'
require 'securerandom'
require 'fileutils'

# Simple, easy to use API for interacting with
# Apache Kafka with Apache Avro. Intended for
# experimentation in development, as nothing here
# is optimized for performance.
module Kril
end
