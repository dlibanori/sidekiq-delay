require 'coveralls'
require 'sidekiq'
require 'mongoid'

Coveralls.wear!

Mongoid.configure do |config|
  config.connect_to('sidekiq_delay_test', consistency: :strong)
end
