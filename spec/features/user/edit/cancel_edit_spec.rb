require 'rails_helper'

RSpec.feature 'Access profile edition then cancel', '
  As a registered user
  In order to find people matching my profile
  I want to edit my personnal informations', :js do

  scenario 'Registered user edit his profile' do
    as_user(user) do
      i_access_my_profile
      i_access_my_profile_edition_page
      i_am_on_my_profile_edition_page
      i_cancel_the_profile_edit
      i_am_back_on_my_profile_page
    end
  end

  private

  let!(:user){User.create(email: "foo@bar.com", password: "password", first_name: "Foofoo", last_name: "Barbar")}
  let!(:previousname){String.new}

  def i_access_my_profile
    navigation.access_menu
    navigation.access_profile
  end

  def i_access_my_profile_edition_page
    profile.access_profile_edition
  end

  def i_am_on_my_profile_edition_page
    expect(page).to have_selector('[data-purpose="profile-edition"]')
  end

  def i_cancel_the_profile_edit
    profile.cancel_edition
  end

  def i_am_back_on_my_profile_page
    expect(page).to have_selector('[data-purpose="user-details"]')
  end
end