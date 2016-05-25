require 'rails_helper'

RSpec.feature 'User browse his friends requests', '
  As a user
  In order to manage my friend requests
  I want to see who I added or who added me as friend', :js do

  scenario 'Registered user checks his friendrequests index' do
    as_user(user) do
      i_access_my_friend_request_page
      sleep 0.5
      my_friend_request_page_is_displayed
      someone_requested_me_as_friend
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password', first_name: 'John', last_name: 'Foo')}
  let!(:puser){User.create(email: 'charlie@gmail.com', password: 'password')}
  let!(:friending){
    puser.friend_request(user, 'Hello add me ! ')
  }

  def i_access_my_friend_request_page
    navigation.access_menu
    navigation.access_friend_requests
  end

  def my_friend_request_page_is_displayed
    expect(page).to have_selector('[data-purpose="friend-requests"]')
  end

  def someone_requested_me_as_friend
    expect(page).to have_selector('[data-purpose="friend-request"]')
    expect(page).to have_content('Hello add me ! ')
  end

end