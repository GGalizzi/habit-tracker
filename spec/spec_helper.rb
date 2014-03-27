require 'timeout'
require 'test_helper'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include TestHelper
  config.before :each do
    Capybara::Session.new(:remote_browser)
    #visit('app://tracker/index.html')
    visit('app://tracker/404.html')
  end

  config.after :each do
    page.driver.browser.navigate.refresh
  end
end
