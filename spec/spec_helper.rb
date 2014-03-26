require 'timeout'
require 'test_helper'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include TestHelper
  config.after :each do
    visit('app://tracker/index.html')
  end
end
