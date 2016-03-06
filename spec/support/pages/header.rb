module Spec
  module Pages
    class Header < SitePrism::Page
      element :learners_button, '[data-purpose="learners_button"]'

      def access_learners_page
        learners_button.click
      end
    end
  end
end