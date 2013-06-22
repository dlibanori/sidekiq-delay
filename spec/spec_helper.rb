require 'sidekiq'
require 'mongoid'
require 'simplecov'
require 'coveralls'

Mongoid.configure do |config|
  config.connect_to('sidekiq_delay_test', consistency: :strong)
end
