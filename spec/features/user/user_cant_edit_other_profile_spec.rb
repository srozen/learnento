require 'rails_helper'

RSpec.feature 'Only profile owner can edit his info', '
  As a registered user
  In order to have a good experience
  I dont want other users to be able to edit my account', :js do

  scenario 'User tries to edit other user account' do
    as_user(user) do
      i_go_on_other_user_profile
      edit_button_is_not_displayed
      i_go_on_other_user_profile_edition

      a_redirection_on_my_profile_has_happened
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password', first_name: 'John', last_name: 'Foo')}
  let!(:otheruser){User.create(email: 'baz@bar.com', password: 'password', first_name: 'Jack', last_name: 'Bauer')}

  def i_go_on_other_user_profile
    visit user_path(otheruser)
  end

  def edit_button_is_not_displayed
    expect(page).not_to have_selector('[data-purpose="edit-profile-button"]')
  end

  def i_go_on_other_user_profile_edition
    visit edit_user_path(otheruser)
  end

  def a_redirection_on_my_profile_has_happened
    expect(page.current_url).to eq "http://www.example.com#{user_path(otheruser)}"
  end

end