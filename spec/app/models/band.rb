require "support/mongoid"
require "sidekiq/delay"

class Band
  include Mongoid::Document
  include Sidekiq::Delay

  def play
    print 'Long running task...'
    sleep 3
    print ' done!'
  end
end
