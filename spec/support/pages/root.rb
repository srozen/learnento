module Spec
  module Pages
    class Root < SitePrism::Page
      element :register_button, '[data-purpose="register_form"]'
      element :email_register, '[data-purpose="register_email"]'
      element :password_register, '[data-purpose="register_password"]'
      element :password_confirmation_register, '[data-purpose="register_password_confirmation"]'
      element :confirm_register, '[data-purpose="register_confirmation"]'

      def access_registration
        regiser_button.click
      end

      def fill_form
        email_register.set("johndoe@foo.bar")
        password_register.set("197foobar197")
        password_confirmation_register.set("197foobar197")
      end

      def confirm_form
        confirm_register.click
      end
    end
  end
end