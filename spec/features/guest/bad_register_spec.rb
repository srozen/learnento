require 'rails_helper'

RSpec.feature 'Guest badly register to Learnento', '
  As a guest
  In order to use Learnento features
  I want to create an account', :js do

  scenario 'Guest badly register to Learnento' do
    i_go_on_root_page
    i_access_register_page
    i_fill_the_form_in
    i_create_my_account
    an_error_occured
    clear_storage
  end

  def i_go_on_root_page
    visit '/'
  end

  def i_access_register_page
    navigation.access_register
  end

  def i_fill_the_form_in
    register.fill_register_form('johndoe@foo.bar', '197foobar197', 'notsamepass')
  end

  def i_create_my_account
    register.confirm_register_form
  end

  def an_error_occured
    expect(page).to have_selector('[data-purpose="error-message"]')
  end
end