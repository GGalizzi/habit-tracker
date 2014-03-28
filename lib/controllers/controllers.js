angular.module('habitsTrackerApp.controllers', [])

.controller('HeaderCtrl', function($scope) {
  $scope.close = function() {
    win.close();
  };
})

.controller('HabitListCtrl', function($scope, Habits) {

  $scope.habits = Habits;
  Habits.loadJson($scope.habits);

  $scope.deleteHabit = Habits.deleteHabit;

  $scope.action = "index";
})

.controller('CreateCtrl', function($scope, Habits) {
  $scope.save = Habits.save;
  $scope.habit = {};
});
