module Spec
  module Pages
    class Register < SitePrism::Page
      element :email_register, '[data-purpose="register-email"]'
      element :password_register, '[data-purpose="register-password"]'
      element :password_confirmation_register, '[data-purpose="register-password-confirmation"]'
      element :confirm_register, '[data-purpose="register-confirmation"]'

      def fill_register_form(email, password, password_confirmation)
        email_register.set(email)
        password_register.set(password)
        password_confirmation_register.set(password_confirmation)
      end

      def confirm_register_form
        confirm_register.click
      end
    end
  end
end