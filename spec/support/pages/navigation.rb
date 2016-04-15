module Spec
  module Pages
    class Navigation < SitePrism::Page
      element :access_register_button, '[data-purpose="access-register-button"]'
      element :access_login_button, '[data-purpose="access-login-button"]'
      element :access_learners_button, '[data-purpose="access-learners-button"]'

      def access_register
        access_register_button.click
      end

      def access_login
        access_login_button.click
      end

      def access_learners_page
        access_learners_button.click
      end
    end
  end
end