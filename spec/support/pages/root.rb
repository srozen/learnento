module Spec
  module Pages
    class Root < SitePrism::Page
      # Register related elements
      element :register_button, '[data-purpose="register_form"]'
      element :email_register, '[data-purpose="register_email"]'
      element :password_register, '[data-purpose="register_password"]'
      element :password_confirmation_register, '[data-purpose="register_password_confirmation"]'
      element :confirm_register, '[data-purpose="register_confirmation"]'

      # Login related elements
      element :login_button, '[data-purpose="login_form"]'
      element :email_login, '[data-purpose="login_email"]'
      element :password_login, '[data-purpose="login_password"]'
      element :confirm_login, '[data-purpose="login_confirmation"]'



      def access_registration
        register_button.click
      end

      def fill_register_form
        email_register.set("johndoe@foo.bar")
        password_register.set("197foobar197")
        password_confirmation_register.set("197foobar197")
      end

      def confirm_register_form
        confirm_register.click
      end

      def access_login
        login_button.click
      end

      def fill_login_form(email,password)
        email_login.set(email)
        password_login.set(password)
      end

      def confirm_login_form
        confirm_login.click
      end
    end
  end
end