require 'sidekiq'
require 'mongoid'
require 'simplecov'
require 'coveralls'

Coveralls.wear!

Mongoid.configure do |config|
  config.connect_to('sidekiq_delay_test', consistency: :strong)
end
