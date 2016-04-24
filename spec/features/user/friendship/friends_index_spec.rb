require 'rails_helper'

RSpec.feature 'User browses his friends list', '
  As a user
  In order to manage my friends
  I want to see who I belongs to my friendlist', :js do

  scenario 'Registered user checks his friends list' do
    as_user(user) do
      i_access_my_friends_page
      my_friends_page_is_displayed
      someone_is_my_friend
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password', first_name: 'John', last_name: 'Foo')}
  let!(:puser){User.create(email: 'charlie@gmail.com', password: 'password')}
  let!(:friending){
    puser.friend_request(user, 'Hello add me ! ')
    user.accept_request(puser)
  }

  def i_access_my_friends_page
    navigation.access_menu
    navigation.access_friendlist
  end

  def my_friends_page_is_displayed
    expect(page).to have_selector('[data-purpose="friendlist"]')
  end

  def someone_is_my_friend
    expect(page).to have_selector('[data-purpose="friend"]')
  end

end