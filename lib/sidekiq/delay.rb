require "sidekiq"
require "sidekiq/delay/version"
require 'active_support/concern'

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

    module DefaultStrategy
      def perfom(yml)
        ((klass, id), method_name, args) = YAML.load(yml)
        record.send(method_name, *args)
      end

      def record(klass, id)
        klass.find(id)
      end
    end

    class DefaultWorker
      include Sidekiq::Worker
      include DefaultStrategy
    end
  end
end
