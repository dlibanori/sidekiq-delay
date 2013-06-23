require "sidekiq/delay"

class TeamWorker
  include Sidekiq::Worker
  include Sidekiq::Delay::Strategy

  def record(klass, id)
    klass.find(id)
  end
end

class Team
  include Sidekiq::Delay

  worker TeamWorker

  def id
    @id ||= rand 10
  end

  def play
    print 'Long task...'
    spleep 3
    print ' done!'
  end
end
