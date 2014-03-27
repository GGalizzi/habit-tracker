angular.module('habitsTrackerApp.controllers', [])

.controller('HeaderCtrl', function($scope) {
  $scope.close = function() {
    win.close();
  };
})

.controller('HabitListCtrl', function($scope, Habits) {
  $scope.habits = Habits;
})

.controller('CreateCtrl', function($location, $scope, Habits) {

  $scope.save = function() {
    t = $scope.habit;
    Habits.values[t.name.toLowerCase()] = t;
    Habits.count += 1;
    Habits.saveToJson(Habits);
    $location.path('/');
  }
});
