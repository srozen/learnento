module Spec
  module Pages
    class ProfileEdition < SitePrism::Page
      element :first_name_input, '[data-purpose="first-name-input"]'
      element :last_name_input, '[data-purpose="last-name-input"]'
      element :avatar_input, '[data-purpose="avatar-input"]'
      element :confirm_edition_button, '[data-purpose="confirm-edition-button"]'

      def upload_avatar(avatar)
        avatar_input.set(avatar)
      end

      def fill_first_name(firstname)
        first_name_input.set(firstname)
      end

      def fill_last_name(lastname)
        last_name_input.set(lastname)
      end

      def confirm_edition
        confirm_edition_button.click
      end
    end
  end
end