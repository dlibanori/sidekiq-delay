require "sidekiq"
require 'active_support/concern'
require "sidekiq/delay/default_worker"

module Sidekiq
  module Delay
    extend ActiveSupport::Concern

    included do
      @worker = DefaultWorker
    end

    def delay(options={})
      Sidekiq::Extensions::Proxy.new \
        self.class.worker,
        [ self.class, self.id ],
        options
    end

    module ClassMethods
      def worker(worker=nil)
        worker ? @worker = worker : @worker
      end
    end
  end
end
