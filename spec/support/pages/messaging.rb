module Spec
  module Pages
    class Messaging < SitePrism::Page

      element :message_input, '[data-purpose="message-input"]'
      element :send_message_button, '[data-purpose="send-message-button"]'

      def send_message(message)
        message_input.set(message)
        send_message_button.click
      end

      def access_conversation(first_name)
        click_link(first_name)
      end
    end
  end
end