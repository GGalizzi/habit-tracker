require 'pry'
require 'json'

module TestHelper
  def visit_app_index
    visit "/index.html"
  end

  def habits_count
    res = page.evaluate_script("angular.element(document).injector().get('Habits').count")
  end

  def reward_of(habit)
    res = page.evaluate_script("angular.element(document.getElementById('scope')).scope().habits.values['#{habit}'].rewards")
  end

  def habits_json 
    fs = File.read('habits.json')
    fo = JSON.parse(fs)
  end

  def truncate_json
    File.open('habits.json', 'w') { |file| file.truncate(0) }
  end
end
