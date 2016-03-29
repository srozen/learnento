require 'rails_helper'

RSpec.feature 'Delete a friend from friendlist', '
  As a user
  In order to control who are in my friendlist
  I want to be able to delete a friend' do

  scenario 'User removes a friend from his friendlist' do
    as_user(user) do
      i_am_friend_with_otheruser
      i_go_on_my_friendlist
      i_remove_otheruser_from_my_friendlist

      my_friendlist_is_empty
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
    header.access_menu
    header.access_friendlist
  end

  def i_remove_otheruser_from_my_friendlist
    friendlist.remove_friend
    friendlist.confirm_removal
  end

  def my_friendlist_is_empty
    expect(page).to have_selector('[data-purpose="friendlist"]')
    expect(page).not_to have_selector('[data-purpose="friend"]')
  end
end