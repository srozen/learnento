require 'rails_helper'

RSpec.feature 'Bad register informations', '
  As a guest
  In order to use Learnento service
  I register an supply bad register infos', :js do

  scenario 'Guest tries to register and gives wrong informations' do
    i_am_on_root_page
    i_go_on_registration_form
    i_fill_the_form_in
    i_create_my_account

    my_account_has_not_been_created
  end

  def i_am_on_root_page
    visit '/'
  end

  def i_go_on_registration_form
    root.access_registration
  end

  def i_fill_the_form_in
    register.fill_register_form("john@foo.bar", "password", "notsamepass")
  end

  def i_create_my_account
    register.confirm_register_form
  end

  def my_account_has_not_been_created
    expect(page.current_url).to eq('http://www.example.com/users')
  end
end