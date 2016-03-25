require 'rails_helper'

RSpec.feature 'User accept friend request', '
  As a user
  In order to chat with someone who sent me a friend request
  I want to to be able to accept his request' do

  scenario 'Registered user accepts a friend request' do
    as_user(user) do
      i_check_my_friend_requests_menu
      i_have_a_new_friend_request
      i_accept_the_friend_request
      i_go_on_my_friendlist

      a_new_friend_has_been_added
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password', first_name: 'John', last_name: 'Foo')}
  let!(:otheruser){User.create(email: 'baz@bar.com', password: 'password', first_name: 'Jack', last_name: 'Bauer')}

  def i_check_my_friend_requests_menu
    header.access_friend_requests
  end

  def i_have_a_new_friend_request
    expect(page).to have_selector('[data-purpose="friend-request"]')
  end

  def i_accept_the_friend_request
    friend_request.accept_friend_request
  end

  def i_go_on_my_friendlist
    header.access_menu
    header.access_friendlist
  end

  def a_new_friend_has_been_added
    expect(page).to have_selector('[data-purpose="friendlist"]')
    expect(page).to have_selector('[data-purpose="friend"]')
  end
end