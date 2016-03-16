module Spec
  module Pages
    class Profile < SitePrism::Page
      element :edit_profile_button, '[data-purpose="edit-profile-button"]'

      def access_profile_edition
        edit_profile_button.click
      end
    end
  end
end