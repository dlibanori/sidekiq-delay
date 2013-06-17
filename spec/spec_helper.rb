require 'sidekiq'
require 'mongoid'

Mongoid.configure do |config|
  config.connect_to('sidekiq_delay_test', consistency: :strong)
end
