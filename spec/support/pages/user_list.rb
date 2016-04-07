module Spec
  module Pages
    class UserList < SitePrism::Page
      element :search_user_input, '[data-purpose="search-user-input"]'
      element :search_user_button, '[data-purpose="search-user-button"]'
      def access_user_profile(first_name)
        click_link first_name
      end

      def search_user(param)
        search_user_input.set(param)
        search_user_button.click
      end
    end
  end
end