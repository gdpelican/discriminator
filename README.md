# Discriminator

Discriminator is a gem which makes ActiveRecord smart about loading subclasses from the database. To wit, say we have a class with subclasses:

```ruby
class Buildings::Base
  def property_value
    raise NotImplementedError.new
  end
end

class Buildings::Library
  def property_value
    "low"
  end
end

class Buildings::Stadium
  def property_value
    "high"
  end
end

class Buildings::SecretBase
  def property_value
    "unknown"
  end
end
```

We might store these in a table, with a `building_type` field to determine what type of building it is:

Now, if we try to do something like
```ruby
Buildings::Library.new(building_type: :library).save
Buildings::Stadium.new(building_type: :stadium).save
Buildings::SecretBase.new(building_type: :secret_base).save
Buildings::Base.all.map(&:class)          # => [Buildings::Base, Buildings::Base, Buildings::Base]
Buildings::Base.all.map(&:property_value) # => NotImplementedError!!
```

...gross. Ideally, we'd like to load up these records from the databases, with their subclasses already applied! With discriminator, if we add a simple line to our building base:

```ruby
discriminate Buildings, on: :building_type
```

Then we get back an `ActiveRecord::Relation` back, with the appropriate subclass already applied.

```ruby
Buildings::Base.all.map(&:class)          # => [Buildings::Library, Buildings::Stadium, Buildings::SecretBase]
Buildings::Base.all.map(&:property_value) # => ["low", "high", "unknown"]
```

This can be exceptionally helpful for a Single Table Inheritance situation, or something like Events
where there may be a large number of subclasses which could have very different behaviour per subclass.

I made this gem so I could use it in [Loomio](http://www.github.com/loomio/loomio).

## Installation

(NB that this functionality relies on ActiveRecord >= 4.0.2, when `discrimiate_class_for_record` was introduced)

Add this line to your application's Gemfile:

```ruby
gem 'discriminator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install discriminator

## Usage

Discriminator defines one method: the `discriminate` method on `ActiveRecord::Base`

```ruby
class Buildings::Base
  discriminate Buildings, on: :building_type
end
```

#### Setting a default

By default, discriminator falls back to `ModuleName::Base`, if a subclass cannot be found but this can be be overridden by the `default` parameter:

```ruby
class Kickflips::Basic
  discriminate Kickflips, on: :type, default: :basic
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gdpelican/discriminator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
