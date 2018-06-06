source 'https://rubygems.org'
ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'pg', '~> 0.20'
gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.10'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'dotenv-rails'
gem 'multi_json'
gem 'json', '~> 1.8', '>= 1.8.3'
gem 'http', '~> 2.1'
gem 'optparse-simple', '~> 0.4.5'
gem 'faraday'
gem 'randumb'
gem 'heroku-forward'
gem 'tzinfo-data'
gem 'resque'
gem 'rake'
gem 'omniauth', '~> 1.7', '>= 1.7.1'
gem 'rufus-scheduler', '~> 3.4', '>= 3.4.2'
gem 'em-proxy', '~> 0.1.9'
gem 'logger', '~> 1.2', '>= 1.2.8'
gem 'dino', '~> 0.11.2'
gem 'foreman', '~> 0.82.0'
gem "bootstrap"
gem 'jquery-rails'
gem 'font-awesome-sass'
gem 'devicon-rails'
gem "font-awesome-rails"
gem 'mechanize', '~> 2.7', '>= 2.7.5'
gem 'yaml_db', '~> 0.6.0'
gem 'jsonpath', '~> 0.5.8'
gem 'activerecord-import', '~> 0.15.0'
gem "figaro"
gem 'scout_apm'
gem 'responders'
gem 'poloniex_ruby'
gem 'securities', '~> 2.0', '>= 2.0.1'
gem 'indicators', '~> 1.0', '>= 1.0.3'
gem 'rootapp-rinruby', '~> 3.1'
gem 'poloniex'
gem 'rinruby', '~> 2.0', '>= 2.0.3'


group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'derailed'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :production do
  gem 'rails_12factor'
end


