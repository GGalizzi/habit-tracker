require 'pry'
require 'json'

module TestHelper
  def visit_app_index
    visit "/index.html"
  end

  def show_content(text)
    page.should have_content(text)
  end

  def habits
    res = page.evaluate_script("angular.element(document).injector().get('Habits').values")
  end

  def habits_count
    res = page.evaluate_script("angular.element(document).injector().get('Habits').count")
  end
  alias_method :habit_count, :habits_count

  def the_habit(habit)
    res = page.evaluate_script("angular.element(document).injector().get('Habits').values['#{habit}']")
  end
  
  def habits_json 
    fs = File.read('habits.json')
    fo = JSON.parse(fs)
  end

  def truncate_json
    File.open('habits.json', 'w') { |file| file.truncate(0) }
  end

  def populate_json
    fs = File.read('tests.json')
    fo = JSON.parse(fs)
    File.open('habits.json', 'w') { |f| f.write(fo.to_json) }
    page.driver.browser.navigate.refresh
  end
end
