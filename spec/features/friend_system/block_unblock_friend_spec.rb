require 'rails_helper'

RSpec.feature 'Blocking and unblocking a friend', '
  As a user
  In order to not being annoyed by some fools
  I want to be able to block a friend', :js do

  scenario 'User blocks a friend and then unblock him' do
    as_user(user) do
      i_am_friend_with_otheruser
      i_go_on_my_friendlist
      i_block_otheruser
      sleep 1

      my_friendlist_contains_a_blocked_menu

      i_unblock_otheruser

      sleep 1

      otheruser_is_in_my_friendlist
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password', first_name: 'John', last_name: 'Foo')}
  let!(:otheruser){User.create(email: 'baz@bar.com', password: 'password', first_name: 'Jack', last_name: 'Bauer')}

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