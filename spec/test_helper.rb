require 'pry'

module TestHelper
  def visit_app_index
    visit "/index.html"
  end

  def tasks_count
    res = page.evaluate_script("angular.element(document.getElementById('scope')).scope().tasks.values.length")
  end
end
