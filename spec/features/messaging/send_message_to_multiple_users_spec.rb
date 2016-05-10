require 'rails_helper'

RSpec.feature 'Sending a message to two friends', '
  As a registered user
  In order to chat with people
  I want to be able to send them messages', :js do

  scenario 'User sends message to a friend, then to another friend' do

    in_browser(:one) do
      sleep 1
      as_user(user) do
        i_go_on_messaging_page
        i_am_on_the_messaging_page
        sleep 2
        i_access_a_conversation(otheruser.first_name)
        i_send_a_message('Foooooo')
        sleep 0.5
        the_message_appeared_in_active_conversation('Foooooo')
        sleep 1
        i_access_a_conversation(randomuser.first_name)
        i_send_a_message('Foooooo')
        sleep 0.5
        the_message_appeared_in_active_conversation('Foooooo')
        sleep 1
      end
    end

    in_browser(:two) do
      sleep 1
      as_user(otheruser) do
        i_go_on_messaging_page
        i_am_on_the_messaging_page
        sleep 0.5
        a_conversation_is_active
        i_have_a_message('Foooooo')
        sleep 1
      end
    end

    in_browser(:three) do
      as_user(randomuser) do
        sleep 0.5
        i_go_on_messaging_page
        i_am_on_the_messaging_page
        sleep 0.5
        a_conversation_is_active
        i_have_a_message('Foooooo')
        sleep 1
      end
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password', first_name: 'Alice', last_name: 'Foo')}
  let!(:otheruser){User.create(email: 'baz@bar.com', password: 'password', first_name: 'Bob', last_name: 'Bauer')}
  let!(:randomuser){User.create(email: 'bub@bar.com', password: 'password', first_name: 'Charlie', last_name: 'Bucker')}
  let!(:friending){
    user.friend_request(otheruser)
    otheruser.accept_request(user)
    Conversation.create!(sender_id: user.id, recipient_id: otheruser.id)
    user.friend_request(randomuser)
    randomuser.accept_request(user)
    Conversation.create!(sender_id: user.id, recipient_id: randomuser.id)
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

  def i_access_a_conversation(first_name)
    messaging.access_conversation(first_name)
  end

  def i_send_a_message(message)
    messaging.send_message(message)
  end

  def the_message_appeared_in_conversation_panel(message)
    expect(find('[data-purpose="conversation-last-message"]').text).to eq message
  end

  def the_message_appeared_in_active_conversation(message)
    expect(page).to have_selector('[data-purpose="message"]')
    expect(find('[data-purpose="message"]').text).to eq message
  end


  def i_have_a_message(message)
    expect(page).to have_selector('[data-purpose="message"]')
    expect(find('[data-purpose="message"]').text).to eq message
  end
end