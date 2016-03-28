module Spec
  module Pages
    class Friendlist < SitePrism::Page
      element :remove_friend_button, '[data-purpose="remove-friend-button"]'
      element :confirm_remove_friend_button, '[data-purpose="confirm-remove-friend-button"]'
      element :cancel_remove_friend_button, '[data-purpose="cancel-remove-friend-button"]'

      def remove_friend
        remove_friend_button.click
      end

      def confirm_removal
        confirm_remove_friend_button.click
      end

      def cancel_removal
        cancel_remove_friend_button.click
      end
    end
  end
end