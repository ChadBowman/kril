# frozen_string_literal: true

require 'kril'
require 'tempfile'
require 'httparty'

SCHEMA_REGISTRY = 'http://localhost:8081'

def temp_file(contents)
  file = Tempfile.new('test_file')
  file.write contents
  file.rewind
  yield file
ensure
  file.close
  file.unlink
end

def schema_registry_available?
  response = HTTParty.get(SCHEMA_REGISTRY)
  response.code.to_i == 200
rescue
  false
end

def integration_test
  skip 'integration test' unless schema_registry_available?
end

