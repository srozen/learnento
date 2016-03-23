module Spec
  module Pages
    class UserList < SitePrism::Page
      def access_user_profile(first_name)
        click_link first_name
      end
    end
  end
end