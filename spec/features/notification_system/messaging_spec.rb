require 'rails_helper'

RSpec.feature 'Messaging notification on navigation panel', '
  As a registered user
  In order to see whenever someone sends me a message
  I want to have a visual information that this happened', :js do

  scenario 'Registered sees a notification when messaged' do

    in_browser(:two) do
      sleep 1
      as_user(otheruser) do
        i_go_on_messaging_page
        i_am_on_the_messaging_page
        sleep 0.5
        a_conversation_is_active
        i_send_a_message('Foooooo')
        sleep 1
      end
    end

    in_browser(:one) do
      sleep 1
      as_user(user) do
        a_messaging_notification_appeared
        messaging_notification_counter_is_at(1)
      end
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password', first_name: 'John', last_name: 'Foo')}
  let!(:otheruser){User.create(email: 'baz@bar.com', password: 'password', first_name: 'Jack', last_name: 'Bauer')}
  let!(:friending){
    user.friend_request(otheruser)
    otheruser.accept_request(user)
    Conversation.create!(sender_id: user.id, recipient_id: otheruser.id)
  }

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

  def messaging_notification_counter_is_at(num)
    expect(find('[data-purpose="messaging-notification"]')).to have_content(num)
  end

  def a_messaging_notification_appeared
    expect(page).to have_selector('[data-purpose="messaging-notification"]')
  end
end