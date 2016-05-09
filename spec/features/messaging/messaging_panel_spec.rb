require 'rails_helper'

RSpec.feature 'Messaging page', '
  As a registered user
  In order to talk with other people
  I want to access the messaging page' do

  scenario 'Registered user goes on the messaging page', :js do
    as_user(user) do
      i_go_on_messaging_page
      i_am_on_the_messaging_page

      there_is_no_conversations
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password')}

  def i_go_on_messaging_page
    navigation.access_messaging_page
  end

  def i_am_on_the_messaging_page
    expect(page).to have_selector('[data-purpose="messaging-page"]')
  end

  def there_is_no_conversations
    expect(page).to have_selector('[data-purpose="no-conversations-advice"]')
  end
end