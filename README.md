# Kril 🦐

Kril is an easy to use command line interface (CLI) for interacting with [Apache Kafka](https://kafka.apache.org/). It uses [Apache Avro](https://avro.apache.org/) for serialization/deserialization.

[![Build Status](https://travis-ci.org/ChadBowman/kril.svg?branch=master)](https://travis-ci.org/ChadBowman/kril)

## Installation

Add this line to your application's Gemspec:

```ruby
spec.add_development_dependency 'kril', '~> 0.1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kril

## Usage

Assuming your schema is not registered with the schema registry, and doesn't exist in the repository, you can define a schema and commit a record like so:
```bash
$ kril --bootstrap-servers 'localhost:9092,localhost:9093,localhost:9094' \
--schema-registry 'http://localhost:8081' \
--schema '{"type":"record","name":"human","fields":[{"name":"age","type":"int"}]}' \
--record '{"age": 27}' \
human
```
```bash
🦐 human: {"age"=>27}
```

Now we can consume a single record:
```bash
$ kril --pretty-print human
```
```bash
🦐 human: 
{
  "key": null,
  "value": {
    "age": 27
  },
  "offset": 0,
  "create_time": "2018-03-04 00:29:47 -0700",
  "topic": "human",
  "partition": 4
}
```
---
Since the schema exists in our repository, we can produce records simply:
```bash
$ kril -r '{"age": 33}' human
```
```bash
🦐 human: {"age"=>33}
```
---
Consuming all records ever:
```bash
$ kril --consume-all human
```
```bash
🦐 human: {:key=>nil, :value=>{"age"=>27}, :offset=>0, :create_time=>2018-03-04 00:12:32 -0700, :topic=>"human", :partition=>2}
🦐 human: {:key=>nil, :value=>{"age"=>27}, :offset=>0, :create_time=>2018-03-04 00:29:47 -0700, :topic=>"human", :partition=>4}
🦐 human: {:key=>nil, :value=>{"age"=>27}, :offset=>0, :create_time=>2018-03-04 00:26:33 -0700, :topic=>"human", :partition=>1}
🦐 human: {:key=>nil, :value=>{"age"=>27}, :offset=>0, :create_time=>2018-03-04 00:25:54 -0700, :topic=>"human", :partition=>3}
🦐 human: {:key=>nil, :value=>{"age"=>33}, :offset=>1, :create_time=>2018-03-04 00:34:07 -0700, :topic=>"human", :partition=>3}
🦐 human: {:key=>nil, :value=>{"age"=>27}, :offset=>0, :create_time=>2018-03-04 00:13:13 -0700, :topic=>"human", :partition=>0}
```
---
The `--schema` option is flexible:
```bash
$ kril --schema /path/to/schema.avsc
$ kril --schema name_of_existing_schema
$ kril --schema '{"type":"record","name":"human","fields":[{"name":"age","type":"int"}]}'
```
---
If no topic is given, the topic will be inferred from the schema name:
```bash
$ kril -s human -r '{"age":99}'
```
```bash
🦐 human: {"age"=>99}
```
---
To see what schemas are saved in the repository:
```bash
$ kril --list-schemas
```
```bash
human, another_schema
```
## Contributing

1. Fork it ( https://github.com/ChadBowman/kril/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Obey 👮[Rubocop](https://github.com/bbatsov/rubocop)! 🚨

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
