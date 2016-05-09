require 'rails_helper'

RSpec.feature 'User accept friend request', '
  As a user
  In order to chat with someone who sent me a friend request
  I want to to be able to accept his request', :js do

  scenario 'Registered user accepts a friend request' do
    as_user(user) do
      otheruser_send_me_a_friend_request
      i_check_my_friend_requests_page
      i_have_a_new_friend_request
      i_accept_the_friend_request
      sleep 1
      i_go_on_my_friendlist
      sleep 1
      a_new_friend_has_been_added

      i_go_on_messaging_page
      i_am_on_the_messaging_page
      sleep 0.5
      a_conversation_is_active
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password', first_name: 'John', last_name: 'Foo')}
  let!(:otheruser){User.create(email: 'baz@bar.com', password: 'password', first_name: 'Jack', last_name: 'Bauer')}

  def otheruser_send_me_a_friend_request
    otheruser.friend_request(user, 'Squalala')
  end

  def i_check_my_friend_requests_page
    navigation.access_friend_requests
  end

  def i_have_a_new_friend_request
    expect(page).to have_selector('[data-purpose="friend-request"]')
    expect(page).to have_selector('[data-purpose="friend-request-message"]')
  end

  def i_accept_the_friend_request
    friend_requests.accept_friend_request
  end

  def i_go_on_my_friendlist
    navigation.access_menu
    navigation.access_friendlist
  end

  def a_new_friend_has_been_added
    expect(page).to have_selector('[data-purpose="friendlist"]')
    expect(page).to have_selector('[data-purpose="friend"]')
  end

  def i_go_on_messaging_page
    navigation.access_messaging_page
  end

  def i_am_on_the_messaging_page
    expect(page).to have_selector('[data-purpose="messaging-page"]')
  end

  def a_conversation_is_active
    expect(page).to have_selector('[data-purpose="active-conversation-header"]')
    expect(page).to have_selector('[data-purpose="active-conversation-messages"]')
  end
end