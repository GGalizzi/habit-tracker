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

  this.deleteHabit = function(scope) {
    scope.$apply(function() {
      delete H.values[scope.habit.name.toLowerCase()];
      scope.habits.count -= 1;
    });
    H.saveToJson(H);
  };

  this.saveToJson = function(val) {
    var jfile = JSON.stringify(val);
    fs.writeFileSync("habits.json", jfile);
  };

  this.loadJson = function(obj) {
    try { 
      parsedJson = JSON.parse(fs.readFileSync('habits.json'));
      obj.values = parsedJson.values;
      obj.count  = parsedJson.count;
      return parsedJson;
    } catch(e) {
      return H;
    }
  };
});
