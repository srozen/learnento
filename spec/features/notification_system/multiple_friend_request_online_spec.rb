require 'rails_helper'

RSpec.feature 'Realtime friend requests notifications', '
  As a registered user
  In order to see whenever someone sends me a friend request
  I want to have a visual information that people are adding me', :js do

  scenario 'Registered sees growing notifications counter when requested as friend' do

    in_browser(:alice) do
      visit '/#/home'
      navigation.access_login
      login.fill_login_form(alice.email, 'password')
      login.confirm_login_form
      expect(page).to have_selector('[data-purpose="user-details"]')
    end

    in_browser(:bob) do
      as_user(bob) do
        i_go_on_learners_page
        profiles_are_displayed
        i_access_a_user_profile
        i_add_this_user_as_friend
      end
    end

    in_browser(:alice) do
      a_notification_appeared
      notification_counter_is_at(1)
    end

    in_browser(:charlie) do
      as_user(charlie) do
        i_go_on_learners_page
        profiles_are_displayed
        i_access_a_user_profile
        i_add_this_user_as_friend
      end
    end

    in_browser(:alice) do
      notification_counter_is_at(2)
      i_check_my_friend_requests_page
      notification_marker_disapeared
      clear_storage
    end
  end

  private

  let!(:alice){User.create(email: 'foo@bar.com', password: 'password', first_name: 'John', last_name: 'Foo')}
  let!(:bob){User.create(email: 'baz@bar.com', password: 'password', first_name: 'Jack', last_name: 'Bauer')}
  let!(:charlie){User.create(email: 'char@bar.com', password: 'password', first_name: 'Charli', last_name: 'Bucki')}

  def notification_counter_is_at(num)
    expect(find('[data-purpose="friend-notification"]')).to have_content(num)
  end

  def notification_marker_disapeared
    expect(page).not_to have_selector('[data-purpose="friend-notification"]')
  end

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
    find('a', text: 'John Foo').click
  end

  def i_add_this_user_as_friend
    profile.send_friend_request
    profile.set_request_message('Hello buddy, accept me !')
    profile.confirm_friend_request
  end

  def i_check_my_friend_requests_page
    navigation.access_friend_requests
  end

end