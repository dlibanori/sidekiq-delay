require 'sidekiq/delay'

class TeamWorker
  include Sidekiq::Worker
  include Sidekiq::Delay::DefaultStrategy

  def record(klass, id)
    klass.find(id)
  end
end

class Team
  include Mongoid::Document
  include Sidekiq::Delay

  worker TeamWorker

  def play
    print 'Long running task...'
    spleep 3
    print ' done!'
  end
end
