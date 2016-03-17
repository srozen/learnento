require 'rails_helper'

RSpec.feature 'Profile edition', '
  As a registered user
  In order to find people matching my profile
  I want to edit my personnal informations' do

  scenario 'Registered user edit his profile' do
    as_user(user) do
      i_access_my_profile
      i_access_my_profile_edition_page
      i_am_on_my_profile_edition_page
      i_fill_the_form_in
      i_confirm_the_edition

      my_informations_have_been_updated
    end
  end

  private

  let!(:user){User.create(email: "foo@bar.com", password: "password")}

  def i_access_my_profile
    header.access_profile_page
  end

  def i_access_my_profile_edition_page
    profile.access_profile_edition
  end

  def i_am_on_my_profile_edition_page
    expect(page).to have_selector('[data-purpose="profile-edition"]')
  end

  def i_fill_the_form_in
    profile_edition.fill_first_name("Samuel")
    profile_edition.fill_last_name("Monroe")
    profile_edition.upload_avatar(Rails.root+'/public/images/pepe.jpg')
  end

  def i_confirm_the_edition
    profile_edition.confirm_edition
  end

  def my_informations_have_been_updated
    expect(page).to have_selector('[data-purpose="success-edit"]')
  end
end