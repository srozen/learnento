require 'rails_helper'

RSpec.feature 'guest access a profile', '
  As a guest
  In order to keep privacy
  I cant access users profiles' do

  scenario 'Guest tries to access a profile page', :js do
    i_am_on_root_page
    i_visit_a_user_profile_page

    a_redirection_on_home_happened
  end

  private

  let!(:user){User.create(email: "foo@bar.baz", password: "password")}

  def i_am_on_root_page
    visit '/'
  end

  def i_visit_a_user_profile_page
    visit %|/#/users/#{user.id}|
  end

  def a_redirection_on_home_happened
    expect(page).to have_selector('[data-purpose="home-page"]')
  end
end