require 'rails_helper'

RSpec.feature 'user logging in', '
  As a registered user
  In order to user Learnento service
  I want to log in my account' do

  scenario 'Registered user wants to log in Pravatar' do
    i_am_on_root_page
    i_go_on_login_form
    i_fill_the_form_in
    i_log_in

    my_session_is_active
  end

  def i_am_on_root_page
    visit '/'
  end

  def i_go_on_login_form
    root.access_login
  end

  def i_fill_the_form_in
    root.fill_login_form('email', 'password')
  end

  def i_log_in
    root.confirm_login_form
  end

  def my_session_is_active
    expect(page).to have_selector('[data-purpose="user_details"]')
  end

end