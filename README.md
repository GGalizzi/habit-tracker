## RSpec-Capybara with Node-Webkit

This is how I managed to use Rspec-Capybara to test [Node-Webkit](https://github.com/rogerwang/node-webkit) applications, if you know of a better way, please let me know!

I hope it can be of use to some people.

### Requirements

+ Install gems `capybara` and `rspec`.
+ Download [Selenium Server Standalone](http://docs.seleniumhq.org/download/) jar and [Node-Webkit's chromedriver2](https://github.com/rogerwang/node-webkit/wiki/Chromedriver).

+ This example applications has the following set-up:
  + An [app protocol](https://github.com/rogerwang/node-webkit/wiki/App-protocol) set-up, which seems to be needed for rspec to visit the app properly, won't work with file protocol.
  + The path to the main file inside `test_helper.rb`, selenium seems to break with Node-Webkit when not running a `before(:each) { visit app_main_file }` for all specs.



### Running
First, place the selenium jar and chromedriver2 in your app's root folder, you will also need to have your nw executable in your root folder (together with nw.pak and whatever you need)

Then run the following selenium server commands:

`java -jar selenium-server-standalone-VERSION.jar -role hub -multiWindow -browserSessionReuse`

`java -jar selenium-server-standalone-VERSION.jar -role webdriver -hub http://127.0.0.1:4444/grid/register -port 5555 -Dwebdriver.chrome.driver=./chromedriver2_server`

Now running `rspec` should open your Node-Webkit application with `chromedriver2_server` which opens the nw executable in the same folder.


### Resources

I came with this solution by reading the following articles:

+ [Chromedriver Node-Webkit wiki entry.](https://github.com/rogerwang/node-webkit/wiki/Chromedriver)
+ [Using RSpec and Capybara Without Rails](http://testerstories.com/using-rspec-and-capybara-without-rails/) by Jeff Nyman.
+ [Running capybara tests in remote browsers](http://altoros.github.io/2013/running-capybara-tests-in-remote-browsers/) by Eugene Melkinov.
