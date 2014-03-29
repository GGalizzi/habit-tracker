require 'timeout'
require 'test_helper'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include TestHelper
  config.before :each do
    visit_app_index
  end

  config.after :each do
    truncate_json
  end
end
