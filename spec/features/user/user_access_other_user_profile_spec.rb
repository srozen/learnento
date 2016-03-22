require 'rails_helper'

## TODO !!

RSpec.feature 'learners browsing', '
  As a registered user
  In order to begin to talk with someone
  I want to access his profile' do

  scenario 'Registered user wants to consult another user profile' do
    as_user(user) do
      i_go_on_learners_page
      profiles_are_displayed
      i_access_a_user_profile

      user_profile_is_displayed
    end
  end

  private

  let!(:user){User.create(username: 'foobar', email: 'foo@bar.com', password: 'password')}
  let!(:otheruser){User.create(username: 'bazbar', email: 'baz@bar.com', password: 'password')}

  def i_go_on_learners_page
    header.access_learners_page
  end

  def profiles_are_displayed
    expect(page).to have_selector('[data-purpose="learners_index"]')
  end

  def i_access_a_user_profile
    user_list.access_user_profile(otheruser.username)
  end

  def user_profile_is_displayed
    expect(page).to have_selector('[data-purpose="user_details"]')
  end
end