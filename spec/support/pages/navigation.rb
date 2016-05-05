module Spec
  module Pages
    class Navigation < SitePrism::Page
      element :access_menu_button, '[data-purpose="menu-button"]'
      element :access_profile_button, '[data-purpose="profile-button"]'
      element :access_register_button, '[data-purpose="access-register-button"]'
      element :access_login_button, '[data-purpose="access-login-button"]'
      element :access_logout_button, '[data-purpose="disconnect-button"]'
      element :access_learners_button, '[data-purpose="access-learners-button"]'
      element :access_friend_requests_button, '[data-purpose="friend-requests-button"]'
      element :access_friendlist_button, '[data-purpose="friendlist-button"]'
      element :access_messaging_page_button, '[data-purpose="messaging-page-button"]'

      def access_menu
        access_menu_button.click
      end

      def access_logout
        access_logout_button.click
      end

      def access_profile
        access_profile_button.click
      end

      def access_register
        access_register_button.click
      end

      def access_login
        access_login_button.click
      end

      def access_learners_page
        access_learners_button.click
      end

      def access_friend_requests
        access_friend_requests_button.click
      end

      def access_friendlist
        access_friendlist_button.click
      end

      def access_messaging_page
        access_messaging_page_button.click
      end
    end
  end
end