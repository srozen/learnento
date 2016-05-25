require 'rails_helper'

RSpec.feature 'Messaging after unblocking', '
  As a registered user
  In order to keep talking with someone
  I want to be able to send him message after unblocking him' do

  scenario 'Registered user goes on the messaging page', :js do
    as_user(user) do
      otheruser_send_me_a_friend_request
      i_check_my_friend_requests_page
      sleep 0.5
      i_have_a_new_friend_request
      i_accept_the_friend_request
      sleep 0.5
      i_go_on_messaging_page
      i_am_on_the_messaging_page
      sleep 0.5
      a_conversation_is_active
      i_send_a_message('Foooooo')
      sleep 0.5
      i_am_friend_with_otheruser
      i_go_on_my_friendlist
      i_block_otheruser
      sleep 1
      my_friendlist_contains_a_blocked_menu
      i_unblock_otheruser
      sleep 1
      otheruser_is_in_my_friendlist
      i_go_on_messaging_page
      i_am_on_the_messaging_page
      sleep 0.5
      a_conversation_is_active
      i_send_a_message('Foooooo')
      sleep 0.5
      i_am_friend_with_otheruser
      i_go_on_my_friendlist
      i_block_otheruser
      sleep 1
    end
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

  def i_send_a_message(message)
    messaging.send_message(message)
  end

  def i_am_friend_with_otheruser
    otheruser.friend_request(user)
    user.accept_request(otheruser)
  end

  def i_go_on_my_friendlist
    navigation.access_menu
    navigation.access_friendlist
  end

  def i_block_otheruser
    friendlist.block_friend
    friendlist.confirm_blocking
  end

  def my_friendlist_contains_a_blocked_menu
    expect(page).not_to have_selector('[data-purpose="friend"]')
  end

  def i_unblock_otheruser
    friendlist.show_blocked
    friendlist.unblock_friend
  end

  def otheruser_is_in_my_friendlist
    expect(page).not_to have_selector('[data-purpose="blocked"]')
    expect(page).to have_selector('[data-purpose="friend"]')
  end
end