require 'rails_helper'

RSpec.feature 'Guest logs in', '
  As a guest
  In order to use Learnento features
  I want to log in', :js do

  scenario 'Guest logs into Learnento' do
    i_go_on_root_page
    i_access_login_page
    i_fill_the_form_in
    i_log_in
    my_session_is_active
    clear_storage
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password')}

  def i_go_on_root_page
    visit '/'
  end

  def i_access_login_page
    navigation.access_login
  end

  def i_fill_the_form_in
    login.fill_login_form(user.email, 'password')
  end

  def i_log_in
    login.confirm_login_form
  end

  def my_session_is_active
    expect(page).to have_selector('[data-purpose="learners-button"]')
  end


end