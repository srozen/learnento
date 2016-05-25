require 'rails_helper'

RSpec.feature 'User accept friend request', '
  As a user
  In order to chat with someone who sent me a friend request
  I want to to be able to accept his request', :js do

  scenario 'Registered user accepts a friend request' do
    as_user(user) do
      otheruser_send_me_a_friend_request
      i_check_my_friend_requests_page
      sleep 0.5
      i_have_a_new_friend_request
      i_accept_the_friend_request
      sleep 2
      the_request_disappeared
    end
    sleep 0.5
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password', first_name: 'John', last_name: 'Foo')}
  let!(:otheruser){User.create(email: 'baz@bar.com', password: 'password', first_name: 'Jack', last_name: 'Bauer')}

  def otheruser_send_me_a_friend_request
    otheruser.friend_request(user, 'Squalala')
  end

  def i_check_my_friend_requests_page
    navigation.access_menu
    navigation.access_friend_requests
  end

  def i_have_a_new_friend_request
    expect(page).to have_selector('[data-purpose="friend-request"]')
    expect(page).to have_selector('[data-purpose="friend-request-message"]')
  end

  def i_accept_the_friend_request
    friend_requests.accept_friend_request
  end

  def the_request_disappeared
    expect(page).not_to have_selector('[data-purpose="friend-request"]')
    expect(user.requested_friends).to eq([])
  end
end