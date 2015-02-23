module Pages
  class Base
    include Capybara::Angular::DSL
    include RSpec::Matchers
    include Rails.application.routes.url_helpers
    include ActionView::Helpers::TextHelper

    def click_chosen_result(text, parent_id = nil)
      find("#{parent_id} .chosen-single").click
      find("#{parent_id} .chosen-results li", text: text).click
    end

    def go
      visit path
      self
    end
  end
end
