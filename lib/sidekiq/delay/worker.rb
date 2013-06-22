require "sidekiq/delay/strategy"

module Sidekiq
  module Delay
    class Worker
      include Sidekiq::Worker
      include Strategy
    end
  end
end
