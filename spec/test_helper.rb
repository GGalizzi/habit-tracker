require 'pry'
require 'json'

module TestHelper
  def visit_app_index
    visit "/index.html"
  end

  def tasks_count
    res = page.evaluate_script("angular.element(document).injector().get('Tasks').count")
  end

  def reward_of(task)
    res = page.evaluate_script("angular.element(document.getElementById('scope')).scope().tasks.values['#{task}'].rewards")
  end

  def tasks_json 
    fs = File.read('tasks.json')
    fo = JSON.parse(fs)
  end

  def truncate_json
    File.open('tasks.json', 'w') { |file| file.truncate(0) }
  end
end
