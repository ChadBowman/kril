
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kril/version'

Gem::Specification.new do |spec|
  spec.name          = 'kril'
  spec.version       = Kril::VERSION
  spec.authors       = ['Chad Bowman']
  spec.email         = ['chad.bowman0@gmail.com']

  spec.summary       = 'A simple command line tool for interacting with Kafka'
  spec.description   = 'Makes producing and consuming topics simple. Useful when experimenting.'
  spec.homepage      = 'https://github.com/ChadBowman/kril'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'bin'
  spec.executables   = ['kril']
  spec.require_paths = ['lib']

  spec.add_dependency 'avro_turf', '~> 0.8.0'
  spec.add_dependency 'clamp', '~> 1.2', '>= 1.2.1'
  spec.add_dependency 'ruby-kafka', '~> 0.5.3'

  spec.add_development_dependency 'httparty', '~> 0.13.7'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'rspec-nc', '~> 0.3.0'
end
