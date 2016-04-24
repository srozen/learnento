require 'rails_helper'

RSpec.feature 'Browse user list', '
  As a registered user
  In order to talk with other people
  I want to know who else is using Learnento' do

  scenario 'Registered user wants to see which people he could talk to', :js do
    as_user(user) do
      i_go_on_learners_page

      profiles_are_displayed
      my_profile_is_not_listed
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password')}
  let!(:otheruser){User.create(email: 'foo@barrbar.com', password: 'password')}

  def i_go_on_learners_page
    navigation.access_learners_page
  end

  def profiles_are_displayed
    expect(page).to have_selector('[data-purpose="learners-index"]')
  end

  def my_profile_is_not_listed
    expect(find('[data-purpose="user-list"]')).not_to have_selector(%|[href="#/users/#{user.id}"]|)
    expect(find('[data-purpose="user-list"]')).to have_selector(%|[href="#/users/#{otheruser.id}"]|)
  end
end