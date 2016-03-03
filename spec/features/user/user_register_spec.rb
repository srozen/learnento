require 'rails_helper'

RSpec.feature 'user registration', '
  As a guest
  In order to use the Learnento service
  I want to register' do

  scenario 'Guest register with valid informations' do
    i_am_on_root_page
    i_go_on_registration_form
    i_fill_the_form_in
    i_create_my_account

    my_account_has_been_created
  end

  def i_am_on_root_page
    visit '/'
  end

  def i_go_on_registration_form
    root.access_registration
  end

  def i_fill_the_form_in
    register.fill_register_form
  end

  def i_create_my_account
    register.confirm_register_form
  end

  def my_account_has_been_created
    expect(page).to have_selector('[data-purpose="first_steps"]')
  end
end