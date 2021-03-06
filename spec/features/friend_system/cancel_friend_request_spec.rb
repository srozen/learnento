require 'rails_helper'

RSpec.feature 'Cancelling friend request', '
  As a user
  In order to control my friend request
  I want to be able to cancel a friend request I made', :js do

  scenario 'User cancel a friend request he just made' do
    as_user(user) do
      i_go_on_learners_page
      profiles_are_displayed
      i_access_a_user_profile
      i_add_this_user_as_friend
      my_friend_request_has_been_sent
      i_go_on_my_friend_requests_page
      i_have_a_pending_friend_request
      i_cancel_the_friend_request

      the_friend_request_has_been_cancelled
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password', first_name: 'John', last_name: 'Foo')}
  let!(:otheruser){User.create(email: 'baz@bar.com', password: 'password', first_name: 'Jack', last_name: 'Bauer')}

  def i_go_on_learners_page
    navigation.access_learners_page
  end

  def profiles_are_displayed
    expect(page).to have_selector('[data-purpose="learners-index"]')
  end

  def i_access_a_user_profile
    user_list.access_user_profile
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
    navigation.access_friend_requests
  end

  def i_have_a_pending_friend_request
    expect(page).to have_selector('[data-purpose="pending-request"]')
  end

  def i_cancel_the_friend_request
    friend_requests.cancel_friend_request
  end

  def the_friend_request_has_been_cancelled
    expect(page).not_to have_selector('[data-purpose="pending-request"]')
  end
end