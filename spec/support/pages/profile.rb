module Spec
  module Pages
    class Profile < SitePrism::Page
      element :edit_profile_button, '[data-purpose="edit-profile-button"]'
      element :send_friend_request_button, '[data-purpose="send-friend-request-button"]'
      element :friend_request_message_input, '[data-purpose="friend-request-message"]'
      element :confirm_friend_request_button, '[data-purpose="confirm-friend-request-button"]'

      def access_profile_edition
        edit_profile_button.click
      end

      def send_friend_request
        send_friend_request_button.click
      end

      def set_request_message(message)
        friend_request_message_input.set(message)
      end

      def confirm_friend_request
        confirm_friend_request_button.click
      end
    end
  end
end