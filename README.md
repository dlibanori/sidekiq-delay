# Sidekiq::Delay

- [![Build Status](https://secure.travis-ci.org/dlibanori/sidekiq-delay.png)](http://travis-ci.org/dlibanori/sidekiq-delay)
- [![Code Climate](https://codeclimate.com/github/dlibanori/sidekiq-delay.png)](https://codeclimate.com/github/dlibanori/sidekiq-delay)
- [![Coverage Status](https://coveralls.io/repos/dlibanori/sidekiq-delay/badge.png)](https://coveralls.io/r/dlibanori/sidekiq-delay)

Wouldn't be nice if you could easily queue model method calls to Sidekiq? With **Sidekiq::Delay** you can!

You have just to include a module and call `delay` before any method call. Actually, your model class have to respond to some methods, but if you are using `ActiveRecord` or `Mongoid` they already do.

**NOTE**: It doesn't support `block` arguments.

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

## How it works

It queues an job with model class, model id, method name and args. Later, at Sidekiq, it finds your model using class and id and calls method with args. Your class must respond to `find(id)` and return same model.

**NOTE**: Your model must be stored at database before `delay` any call.

## Custom works

What if you class doesn't respond to `find` or you want to use another `Sidekiq` plugin? You can easily write an **custom worker**. You have just to set your model to use it with `worker` method.

Your worker just need to include `Sidekiq::Delay::DefaultStrategy` or extend `Sidekiq::Delay::DefaultWorker`.

```ruby
  class TeamWorker
    include Sidekiq::Worker
    include Sidekiq::Delay::DefaultStrategy

    def record(klass, id)
      klass.custom_find(id)
    end
  end

  class Team
    include Mongoid::Document
    include Sidekiq::Delay

    worker TeamWorker

    field :name

    def self.custom_find(id)
      find(id)
    end

    def play!
      # it is a long task
      sleep 3
    end
  end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
