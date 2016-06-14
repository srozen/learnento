source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails', '4.2.5'
gem 'pg', '~> 0.18.4'
gem 'devise', '~> 3.5', '>= 3.5.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'memoist', '~> 0.14.0'
gem 'jquery-rails'
gem 'font-awesome-rails'
gem 'carrierwave'
gem 'coveralls', require: false
gem 'has_friendship', git: 'git://github.com/srozen/has_friendship.git'
gem 'puma'
gem 'bower-rails', '~> 0.10.0'
gem 'faker', '~> 1.6', '>= 1.6.3'
gem 'angular-rails-templates'
gem 'sprockets', '2.12.3'
gem 'jwt'
gem 'api-versions', '~> 1.2', '>= 1.2.1'
gem 'redis', '~> 3.2', '>= 3.2.2'



source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end


group :test do
  gem 'capybara'
  gem 'site_prism'
  gem 'capybara-screenshot'
  gem 'database_cleaner', '~> 1.5', '>= 1.5.1'
  gem 'selenium-webdriver', '~> 2.53'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'teaspoon-jasmine', '~> 2.2'
  gem 'phantomjs', '~> 2.1', '>= 2.1.1.0'
  gem 'poltergeist', '~> 1.9'
  gem 'rails-erd', '~> 1.4', '>= 1.4.7'
end

group :development do
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano', '~> 3.4', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-db-tasks', require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-maintenance', '~> 1.0', require: false
  gem 'airbrussh', require: false
  gem 'highline', require: false
  gem 'capistrano-faster-assets', require: false
  gem 'thin', '~> 1.6', '>= 1.6.4'
end