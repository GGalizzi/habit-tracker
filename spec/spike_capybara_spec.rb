require 'pry'
Capybara.register_driver :remote_browser do |app|
  Capybara::Selenium::Driver.new(app,
                                 :browser => :remote,
                                 :desired_capabilities => :chrome)
end


Capybara.run_server = false
Capybara.app_host = 'app://tracker'
Capybara.default_driver = :remote_browser
Capybara.javascript_driver = :remote_browser


# Changes made to make session reset not get stuck.
class Capybara::Selenium::Driver
  def reset!
    # Use instance variable directly so we avoid starting the browser just to reset the session
    if @browser
      begin @browser.manage.delete_all_cookies
      rescue Selenium::WebDriver::Error::UnhandledError
        # delete_all_cookies fails when we've previously gone
        # to about:blank, so we rescue this error and do nothing
        # instead.
      end
      @browser.navigate.to("nw:blank")
    end
  end
end

class Capybara::Session
  def reset!
    if @touched
      driver.reset!
      @touched = false
      #assert_no_selector :xpath, "/html/body/*"
    end
    raise @server.error if Capybara.raise_server_errors and @server and @server.error
  ensure
    @server.reset_error! if @server
  end
  alias_method :cleanup!, :reset!
  alias_method :reset_session!, :reset!

end
