source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails', '4.2.5'
gem 'pg', '~> 0.18.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'memoist', '~> 0.14.0'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'jquery-rails'
gem 'devise'
gem 'font-awesome-rails'
gem 'carrierwave'
gem 'coveralls', require: false
gem 'has_friendship', path: './app/gems/has_friendship'
gem 'puma'


source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end


group :test do
  gem 'capybara'
  gem 'site_prism'
  gem 'capybara-screenshot'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
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
end