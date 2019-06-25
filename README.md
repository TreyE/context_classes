# context-classes

A gem to help with configurable constant resolution, with optional constraints.

I wanted, but could not find, a gem which would allow me to:
1. Resolve desired dependencies
2. Select those dependencies via an easily deployed and edited configuration, with NO CODING.
3. Provide a way to verify my required dependencies are provided by the configuration - so that nothing is missed and surprises the developer or runtime system later.
4. Add constraints to the allowed dependencies, such as a required  superclass or included module.
5. Be used ONLY where explicitly desired.
6. Be easily mockable and testable.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'context_classes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install context_classes

## Usage

### Define your context configuration

```ruby
class MyContext
  include ContextClasses::Config

  self.config_file = File.join(Rails.root, "config", "context_classes.yml")

  context :some_context do
    key :the_key
  end
end
```

You will need to initialize the configuration, you can do this in a Rails initializer or anywhere you feel like invoking:
```ruby
ContextClasses.configure_using(MyContext)
```

### Create your YAML config file

Create a yaml config file the specifies what dependencies you would like:
```yaml
some_context:
  the_key: MyClassName
```

### Resolve your dependencies

Once you have created your config file and defined your context configuration, you can start resolving constants right away:
```ruby
ContextClasses.resolve_class("some_context.the_key")
```

If you need just the name, rather than the actual constant, you can instead request the constant name:
```ruby
ContextClasses.resolve_class_name("some_context.the_key")
```
This is useful for defining rails associations, where you might want to use the `class_name` argument for example.


### Testing

Testing is as simple as mocking invocations to `ContextClasses.resolve_class` and returning the value of your choice.

## Advanced Usage

You can also specify constraints on your provided constants, which will be verified at configuration time:
```ruby
  context :my_service_context do
    key :input_validator, kind_of: Dry::Schema
  end
```
```yaml
my_service_context:
  input_validator: Integer
```

In this case `ContextClasses.configure_using` will tell you your provided dependencies are invalid.

Right now 'kind_of' is the only available validation, but more are planned.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
