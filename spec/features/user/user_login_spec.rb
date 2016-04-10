require 'rails_helper'

RSpec.feature 'user logging in', '
  As a registered user
  In order to user Learnento service
  I want to log in my account', :js do

  scenario 'Registered user wants to log in Pravatar' do
    i_am_on_root_page
    i_go_on_login_form
    i_fill_the_form_in
    i_log_in

    my_session_is_active
  end

  private

  let!(:user){User.create(email: "foo@bar.com", password: "password")}
  def i_am_on_root_page
    visit '/'
  end

  def i_go_on_login_form
    root.access_login
  end

  def i_fill_the_form_in
    login.fill_login_form(user.email, 'password')
  end

  def i_log_in
    login.confirm_login_form
  end

  def my_session_is_active
    expect(page).to have_selector('[data-purpose="user-details"]')
  end

end