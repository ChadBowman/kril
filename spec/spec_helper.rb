# frozen_string_literal: true

require 'kril'
require 'tempfile'

def temp_file(contents)
  file = Tempfile.new('test_file')
  file.write contents
  file.rewind
  yield file
ensure
  file.close
  file.unlink
end
