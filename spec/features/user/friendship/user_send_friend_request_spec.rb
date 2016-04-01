require 'rails_helper'

RSpec.feature 'User send friend request', '
  As a registered user
  In order to talk with people
  I want to send a friend request to someone with a message' do

  scenario 'Registered user send a friend request to another user' do
    as_user(user) do
      i_go_on_learners_page
      profiles_are_displayed
      i_access_a_user_profile
      i_add_this_user_as_friend

      my_friend_request_has_been_sent

      i_go_on_my_friend_requests_page
      i_have_a_pending_friend_request
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
    user_list.access_user_profile(otheruser.first_name)
  end

  def i_add_this_user_as_friend
    profile.send_friend_request
    profile.set_request_message('Hello buddy, accept me !')
    profile.confirm_friend_request
  end

  def my_friend_request_has_been_sent
    expect(page).to have_selector('[data-purpose="pending-friend-request-button"]')
  end

  def i_go_on_my_friend_requests_page
    header.access_friend_requests
  end

  def i_have_a_pending_friend_request
    expect(page).to have_selector('[data-purpose="pending-request"]')
  end
end