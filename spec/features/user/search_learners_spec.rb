require 'rails_helper'

RSpec.feature 'User search engine', '
  As a registered user
  In order to find people to add as friend
  I want to be able to search in the user list', :js do

  scenario 'Registered user search for a user in user index' do
    as_user(user) do
      i_go_on_learners_page
      i_search_for_otheruser_first_name

      other_user_is_displayed
    end
  end

  private

  let!(:user){User.create(email: 'foo@bar.com', password: 'password', first_name: 'John', last_name: 'Foo')}
  let!(:otheruser){User.create(email: 'baz@bar.com', password: 'password', first_name: 'Jack', last_name: 'Bauer')}

  def i_go_on_learners_page
    navigation.access_learners_page
  end

  def i_search_for_otheruser_first_name
    user_list.search_user('Jack')
  end

  def other_user_is_displayed
    expect(page).to have_selector('[data-purpose="user"]')
  end
end