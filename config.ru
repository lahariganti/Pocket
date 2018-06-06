require 'rubygems'
require 'bundler'
require 'em-proxy'
require 'logger'
require 'heroku-forward'
require 'heroku/forward/backends/puma'

$stdout.sync = true
Bundler.require(:rack)

port = (ARGV.first || ENV['PORT'] || 3000).to_i
env = ENV['RACK_ENV']

application = File.expand_path('../altbot.ru', __FILE__)
config_file = File.expand_path('../config/puma.rb', __FILE__)
backend = Heroku::Forward::Backends::Puma.new(application: application, env: env, config_file: config_file)
proxy = Heroku::Forward::Proxy::Server.new(backend, host: '0.0.0.0', port: port)
proxy.forward!

# This file is used by Rack-based servers to start the application.

require File.expand_path('../config/environment',  __FILE__)
run Rails.application
