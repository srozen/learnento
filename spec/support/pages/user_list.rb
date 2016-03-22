module Spec
  module Pages
    class UserList < SitePrism::Page
      def access_user_profile(username)
        click_button username
      end
    end
  end
end