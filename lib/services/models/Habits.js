angular.module('habitsTrackerApp.services', [])

.service('Habits', function() {
  this.values = {};
  this.count = 0;
  this.saveToJson = function(val) {
    var jfile = JSON.stringify(val);
    fs.writeFileSync("habits.json", jfile);
  };
});
