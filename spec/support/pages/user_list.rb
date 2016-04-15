module Spec
  module Pages
    class UserList < SitePrism::Page
      element :search_user_input, '[data-purpose="search-user-input"]'
      element :search_user_button, '[data-purpose="search-user-button"]'
      element :user_profile_button, '[data-purpose="user-profile-button"]'
      def access_user_profile
        user_profile_button.click
      end

      def search_user(param)
        search_user_input.set(param)
      end
    end
  end
end