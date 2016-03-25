module Spec
  module Pages
    class Header < SitePrism::Page
      element :learners_button, '[data-purpose="learners_button"]'
      element :profile_button, '[data-purpose="profile-button"]'
      element :menu_button, '[data-purpose="menu-button"]'
      element :friend_requests_button, '[data-purpose="friend-requests-button"]'
      element :friendlist_button, '[data-purpose="friendlist-button"]'

      def access_learners_page
        learners_button.click
      end

      def access_profile_page
        profile_button.click
      end

      def access_friend_requests
        friend_requests_button.click
      end

      def access_friendlist
        friendlist_button.click
      end

      def access_menu
        menu_button.click
      end
    end
  end
end