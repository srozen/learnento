module Spec
  module Pages
    class Root < SitePrism::Page
      # Register related elements
      element :register_button, '[data-purpose="register-form"]'
      element :login_button, '[data-purpose="login-form"]'

      def access_registration
        register_button.click
      end

      def access_login
        login_button.click
      end

    end
  end
end