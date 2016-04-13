require 'rails_helper'

RSpec.feature 'Guest logs in', '
  As a guest
  In order to use Learnento features
  I want to log in', :js do

  scenario 'Guest logs into Learnento' do
    i_go_on_root_page
    i_access_login_page
  end

  def i_go_on_root_page
    visit '/'
  end

  def i_access_login_page
    navigation.access_login
  end
end