Capybara.asset_host = 'http://localhost:3000' # enable asset in save_and_open_page if we have a dev server running

=begin
RSpec.configure do |config|
  config.before(:each, type: :feature) do
    page.driver.header 'ACCEPT', 'text/html'
  end
end
=end
