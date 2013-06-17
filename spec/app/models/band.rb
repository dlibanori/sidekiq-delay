require 'sidekiq/delay'

class Band
  include Mongoid::Document
  include Sidekiq::Delay

  def play
    print 'Long running task...'
    spleep 3
    print ' done!'
  end
end
