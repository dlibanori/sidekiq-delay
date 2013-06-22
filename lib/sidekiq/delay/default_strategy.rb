module Sidekiq
  module Delay
    module DefaultStrategy
      def perform(yml)
        ((klass, id), method_name, args) = YAML.load(yml)
        record(klass, id).send(method_name, *args)
      end

      def record(klass, id)
        klass.find(id)
      end
    end
  end
end
