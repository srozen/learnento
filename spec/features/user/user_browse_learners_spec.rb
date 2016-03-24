require 'rails_helper'

RSpec.feature 'Browse user list', '
  As a registered user
  In order to talk with other people
  I want to know who else is using Learnento' do

  scenario 'Registered user wants to see which people he could talk to' do
    as_user(user) do
      i_go_on_learners_page

      profiles_are_displayed
      my_profile_is_not_listed
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password')}

  def i_go_on_learners_page
    header.access_learners_page
  end

  def profiles_are_displayed
    expect(page).to have_selector('[data-purpose="learners_index"]')
  end

  def my_profile_is_not_listed
    expect(find('[data-purpose="user-list"]')).not_to have_selector(%|[href="#{user_path(user)}"]|)
  end
end