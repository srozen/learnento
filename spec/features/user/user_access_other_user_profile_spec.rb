require 'rails_helper'

RSpec.feature 'learners browsing', '
  As a registered user
  In order to begin to talk with someone
  I want to access his profile', js: true do

  scenario 'Registered user wants to consult another user profile' do
    as_user(user) do
      i_go_on_learners_page
      profiles_are_displayed
      i_access_a_user_profile

      user_profile_is_displayed
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password', first_name: 'John', last_name: 'Foo')}
  let!(:otheruser){User.create(email: 'baz@bar.com', password: 'password', first_name: 'Jack', last_name: 'Bauer')}

  def i_go_on_learners_page
    header.access_learners_page
  end

  def profiles_are_displayed
    expect(page).to have_selector('[data-purpose="learners_index"]')
  end

  def i_access_a_user_profile
    user_list.access_user_profile
  end

  def user_profile_is_displayed
    expect(page).to have_selector('[data-purpose="user-details"]')
  end
end