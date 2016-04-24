
module Spec
  module Pages
    class FriendRequests < SitePrism::Page
      element :accept_friend_request_button, '[data-purpose="accept-friend-request-button"]'
      element :decline_friend_request_button, '[data-purpose="decline-friend-request-button"]'
      #element :cancel_friend_request_button, '[data-purpose="cancel-friend-request-button"]'

      def accept_friend_request
        accept_friend_request_button.click
      end


      def decline_friend_request
        decline_friend_request_button.click
      end

=begin
      def cancel_friend_request
        cancel_friend_request_button.click
      end
=end
    end
  end
end