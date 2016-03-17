module Spec
  module Pages
    class Header < SitePrism::Page
      element :learners_button, '[data-purpose="learners_button"]'
      element :profile_button, '[data-purpose="profile-button"]'

      def access_learners_page
        learners_button.click
      end

      def access_profile_page
        profile_button.click
      end
    end
  end
end