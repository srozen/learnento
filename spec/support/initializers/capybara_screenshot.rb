#require 'launchy'
require 'capybara/rspec'
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'

Capybara.save_path = Rails.root.join('tmp', 'save_and_open_page')
Capybara::Screenshot.prune_strategy = { keep: 20 }

=begin
Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot path
end
=end