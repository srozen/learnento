require 'rails_helper'

RSpec.feature 'Notification on friend_request panel', '
  As a registered user
  In order to see whenever someone sends me a friend request
  I want to have a visual information that this happened', :js do

  scenario 'Registered sees a notification when requested as friend' do
    in_browser(:one) do
      sleep 0.5
      as_user(user) do
        sleep 0.5
      end
    end

    in_browser(:two) do
      as_user(otheruser) do
        i_go_on_learners_page
        profiles_are_displayed
        i_access_a_user_profile
        i_add_this_user_as_friend
        sleep 1
      end
    end

    in_browser(:one) do
        a_notification_appeared
        clear_storage
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password', first_name: 'John', last_name: 'Foo')}
  let!(:otheruser){User.create(email: 'baz@bar.com', password: 'password', first_name: 'Jack', last_name: 'Bauer')}


  def a_notification_appeared
    expect(page).to have_selector('[data-purpose="friend-notification"]')
  end

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
end