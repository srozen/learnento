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

    my_profile_is_displayed
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

  def my_profile_is_displayed
    expect(page).to have_content(user.email)
  end

end