require "sidekiq/delay/default_strategy"

module Sidekiq
  module Delay
    class DefaultWorker
      include Sidekiq::Worker
      include DefaultStrategy
    end
  end
end
