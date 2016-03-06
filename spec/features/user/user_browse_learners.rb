require 'rails_helper'

## TODO !!

RSpec.feature 'learners browsing', '
  As a registered user
  In order to talk with other people
  I want to know who else is using Learnento' do

  scenario 'Registered user wants to see which people he could talk to' do
    as_user(user) do
      i_go_on_learners_page

      profiles_are_displayed
    end
  end

  private

  let!(:user){User.create(email: "foo@bar.com", password: "password")}

  def i_go_on_learners_page
    header.access_learners_page
  end

  def profiles_are_displayed
    expect(page).to have_selector('[data-purpose="learners_index"]')
  end
end