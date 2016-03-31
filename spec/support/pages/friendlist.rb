module Spec
  module Pages
    class Friendlist < SitePrism::Page
      # Remove
      element :remove_friend_button, '[data-purpose="remove-friend-button"]'
      element :confirm_remove_friend_button, '[data-purpose="confirm-remove-friend-button"]'
      element :cancel_remove_friend_button, '[data-purpose="cancel-remove-friend-button"]'
      # Block
      element :block_friend_button, '[data-purpose="block-friend-button"]'
      element :confirm_block_friend_button, '[data-purpose="confirm-block-friend-button"]'
      element :cancel_block_friend_button, '[data-purpose="cancel-block-friend-button"]'
      # Unblock
      element :blocked_friends_button, '[data-purpose="blocked-friends-button"]'
      element :unblock_friend_button, '[data-purpose="unblock-friend-button"]'

      def remove_friend
        remove_friend_button.click
      end

      def confirm_removal
        confirm_remove_friend_button.click
      end

      def cancel_removal
        cancel_remove_friend_button.click
      end

      def block_friend
        block_friend_button.click
      end

      def confirm_blocking
        confirm_block_friend_button.click
      end

      def cancel_blocking
        cancel_block_friend_button.click
      end

      def show_blocked
        blocked_friends_button.click
      end

      def unblock_friend
        unblock_friend_button.click
      end

    end
  end
end