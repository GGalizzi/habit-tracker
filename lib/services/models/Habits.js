angular.module('habitsTrackerApp.services', [])

.service('Habits', function($location) {
  this.values = {};
  this.count = 0;

  var H = this;
  this.save = function(habit) {
    if(!H.values[habit.name.toLowerCase()]) {
      habit.level = 1;
      habit.points = 0;
      habit.pointsToLevel = 500;
      H.values[habit.name.toLowerCase()] = habit;
      H.count += 1;
      H.saveToJson(H);
      $location.path('/');
    }
  };

  this.saveToJson = function(val) {
    var jfile = JSON.stringify(val);
    fs.writeFileSync("habits.json", jfile);
  };
});
