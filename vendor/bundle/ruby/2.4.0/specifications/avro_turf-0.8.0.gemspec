# -*- encoding: utf-8 -*-
# stub: avro_turf 0.8.0 ruby lib

Gem::Specification.new do |s|
  s.name = "avro_turf".freeze
  s.version = "0.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Daniel Schierbeck".freeze]
  s.date = "2017-03-06"
  s.email = ["dasch@zendesk.com".freeze]
  s.homepage = "https://github.com/dasch/avro_turf".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "\navro_turf v0.8.0 deprecates the names AvroTurf::SchemaRegistry,\nAvroTurf::CachedSchemaRegistry, and FakeSchemaRegistryServer.\n\nUse AvroTurf::ConfluentSchemaRegistry, AvroTurf::CachedConfluentSchemaRegistry,\nand FakeConfluentSchemaRegistryServer instead.\n\nSee https://github.com/dasch/avro_turf#deprecation-notice\n".freeze
  s.rubygems_version = "2.7.6".freeze
  s.summary = "A library that makes it easier to use the Avro serialization format from Ruby".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<avro>.freeze, ["< 1.9", ">= 1.7.7"])
      s.add_runtime_dependency(%q<excon>.freeze, ["~> 0.45"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.2.0"])
      s.add_development_dependency(%q<fakefs>.freeze, ["~> 0.6.7"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_development_dependency(%q<sinatra>.freeze, [">= 0"])
      s.add_development_dependency(%q<json_spec>.freeze, [">= 0"])
    else
      s.add_dependency(%q<avro>.freeze, ["< 1.9", ">= 1.7.7"])
      s.add_dependency(%q<excon>.freeze, ["~> 0.45"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.2.0"])
      s.add_dependency(%q<fakefs>.freeze, ["~> 0.6.7"])
      s.add_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_dependency(%q<sinatra>.freeze, [">= 0"])
      s.add_dependency(%q<json_spec>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<avro>.freeze, ["< 1.9", ">= 1.7.7"])
    s.add_dependency(%q<excon>.freeze, ["~> 0.45"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.2.0"])
    s.add_dependency(%q<fakefs>.freeze, ["~> 0.6.7"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<sinatra>.freeze, [">= 0"])
    s.add_dependency(%q<json_spec>.freeze, [">= 0"])
  end
end
