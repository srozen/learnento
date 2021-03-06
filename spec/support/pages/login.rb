module Spec
  module Pages
    class Login < SitePrism::Page
      element :email_login, '[data-purpose="login-email"]'
      element :password_login, '[data-purpose="login-password"]'
      element :confirm_login, '[data-purpose="login-confirmation"]'

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