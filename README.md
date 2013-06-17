# Sidekiq::Delay

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq-delay'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-delay

## Usage

First you have to include `Sidekiq::Delay` at your model.

```ruby
class Band
  include Mongoid::Document
  include Sidekiq::Delay

  field :name

  def play!
    # it is a long task
    sleep 3
  end
end
```

Now you can `delay` method calls to a Sidekiq queue.

```ruby
band = Band.create(name: 'Daft Punk')

band.delay.play!
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
