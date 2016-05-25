require 'rails_helper'

RSpec.feature 'Declining a friend request', '
  As a user
  In order not to speak with people I dont like
  I want to be able to decline a request', :js do

  scenario 'User decline a friend request in his request page' do
    as_user(user) do
      otheruser_send_me_a_friend_request
      i_check_my_friend_requests_menu
      sleep 0.5
      i_have_a_new_friend_request
      i_decline_the_friend_request
      i_go_on_my_friendlist

      my_friendlist_is_empty
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password', first_name: 'John', last_name: 'Foo')}
  let!(:otheruser){User.create(email: 'baz@bar.com', password: 'password', first_name: 'Jack', last_name: 'Bauer')}

  def otheruser_send_me_a_friend_request
    otheruser.friend_request(user, 'Hello add me ! ')
  end

  def i_check_my_friend_requests_menu
    navigation.access_menu
    navigation.access_friend_requests
  end

  def i_have_a_new_friend_request
    expect(page).to have_selector('[data-purpose="friend-request"]')
  end

  def i_decline_the_friend_request
    friend_requests.decline_friend_request
  end

  def i_go_on_my_friendlist
    navigation.access_menu
    navigation.access_friendlist
  end

  def my_friendlist_is_empty
    expect(page).to have_selector('[data-purpose="friendlist"]')
    expect(page).not_to have_selector('[data-purpose="friend"]')
  end
end