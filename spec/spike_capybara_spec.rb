Capybara.register_driver :remote_browser do |app|
  Capybara::Selenium::Driver.new(app,
                                 :browser => :remote,
                                 :desired_capabilities => :chrome)
end

Capybara.run_server = false
Capybara.app_host = 'app://tracker'
Capybara.default_driver = :remote_browser
Capybara.javascript_driver = :remote_browser
