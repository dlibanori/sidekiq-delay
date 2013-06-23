require "sidekiq/delay"

class Band
  include Sidekiq::Delay

  def id
    @id ||= rand 10
  end

  def play
    print 'Long task...'
    sleep 3
    print ' done!'
  end
end
