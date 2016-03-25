module Spec
  module Pages
    class FriendRequests < SitePrism::Page
      element :accept_friend_request_button, '[data-purpose="accept-friend-request-button"]'

      def accept_friend_request
        accept_friend_request_button.click
      end
    end
  end
end