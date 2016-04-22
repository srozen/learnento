module Spec
  module Pages
    class Profile < SitePrism::Page
      element :edit_profile_button, '[data-purpose="edit-profile-button"]'
      element :first_name, '[data-purpose="first-name"]'
      element :cancel_edition_button, '[data-purpose="cancel-edition"]'

      def access_profile_edition
        edit_profile_button.click
      end

      def cancel_edition
        cancel_edition_button.click
      end

      def get_first_name
        first_name.text
      end

    end
  end
end