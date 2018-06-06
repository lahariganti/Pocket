require_relative 'boot'
require "sprockets/railtie"
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cry
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.time_zone = 'Central Time (US & Canada)'
    config.active_record.default_timezone = :utc
    config.load_defaults 5.1
    config.autoload_paths << Rails.root.join('lib')
  end
end

PoloniexRuby.setup do | config |
  config.key = ENV['API_KEY']
  config.secret = ENV['SECRET_TOKEN']
end

# Poloniex.setup do | config |
# 	config.key = 'my api key'
# 	config.secret = 'my secret token'
# end

