require 'rails_helper'

RSpec.feature 'Guest register to Learnento', '
  As a guest
  In order to use Learnento features
  I want to create an account', :js do

  scenario 'Guest register to Learnento' do
    i_go_on_root_page
    i_access_login_page
  end

  def i_go_on_root_page
    visit '/'
  end

  def i_access_login_page
    navigation.access_register
  end
end