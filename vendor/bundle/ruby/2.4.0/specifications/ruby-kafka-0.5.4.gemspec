# -*- encoding: utf-8 -*-
# stub: ruby-kafka 0.5.4 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby-kafka".freeze
  s.version = "0.5.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Daniel Schierbeck".freeze]
  s.bindir = "exe".freeze
  s.date = "2018-03-16"
  s.description = "A client library for the Kafka distributed commit log.".freeze
  s.email = ["daniel.schierbeck@gmail.com".freeze]
  s.homepage = "https://github.com/zendesk/ruby-kafka".freeze
  s.licenses = ["Apache License Version 2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "A client library for the Kafka distributed commit log.".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.9.5"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<dotenv>.freeze, [">= 0"])
      s.add_development_dependency(%q<docker-api>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-benchmark>.freeze, [">= 0"])
      s.add_development_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_development_dependency(%q<snappy>.freeze, [">= 0"])
      s.add_development_dependency(%q<extlz4>.freeze, [">= 0"])
      s.add_development_dependency(%q<colored>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec_junit_formatter>.freeze, ["= 0.2.2"])
      s.add_development_dependency(%q<dogstatsd-ruby>.freeze, [">= 3.0.0"])
      s.add_development_dependency(%q<statsd-ruby>.freeze, [">= 0"])
      s.add_development_dependency(%q<ruby-prof>.freeze, [">= 0"])
      s.add_development_dependency(%q<timecop>.freeze, [">= 0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.49.1"])
      s.add_development_dependency(%q<gssapi>.freeze, [">= 1.2.0"])
      s.add_development_dependency(%q<stackprof>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, [">= 1.9.5"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<dotenv>.freeze, [">= 0"])
      s.add_dependency(%q<docker-api>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-benchmark>.freeze, [">= 0"])
      s.add_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_dependency(%q<snappy>.freeze, [">= 0"])
      s.add_dependency(%q<extlz4>.freeze, [">= 0"])
      s.add_dependency(%q<colored>.freeze, [">= 0"])
      s.add_dependency(%q<rspec_junit_formatter>.freeze, ["= 0.2.2"])
      s.add_dependency(%q<dogstatsd-ruby>.freeze, [">= 3.0.0"])
      s.add_dependency(%q<statsd-ruby>.freeze, [">= 0"])
      s.add_dependency(%q<ruby-prof>.freeze, [">= 0"])
      s.add_dependency(%q<timecop>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.49.1"])
      s.add_dependency(%q<gssapi>.freeze, [">= 1.2.0"])
      s.add_dependency(%q<stackprof>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, [">= 1.9.5"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<dotenv>.freeze, [">= 0"])
    s.add_dependency(%q<docker-api>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-benchmark>.freeze, [">= 0"])
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_dependency(%q<snappy>.freeze, [">= 0"])
    s.add_dependency(%q<extlz4>.freeze, [">= 0"])
    s.add_dependency(%q<colored>.freeze, [">= 0"])
    s.add_dependency(%q<rspec_junit_formatter>.freeze, ["= 0.2.2"])
    s.add_dependency(%q<dogstatsd-ruby>.freeze, [">= 3.0.0"])
    s.add_dependency(%q<statsd-ruby>.freeze, [">= 0"])
    s.add_dependency(%q<ruby-prof>.freeze, [">= 0"])
    s.add_dependency(%q<timecop>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.49.1"])
    s.add_dependency(%q<gssapi>.freeze, [">= 1.2.0"])
    s.add_dependency(%q<stackprof>.freeze, [">= 0"])
  end
end
