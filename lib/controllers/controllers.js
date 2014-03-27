angular.module('habitsTrackerApp.controllers', [])

.controller('HeaderCtrl', function($scope) {
  $scope.close = function() {
    win.close();
  };
})

.controller('HabitListCtrl', function($scope, Habits) {
  $scope.habits = Habits;
})

.controller('CreateCtrl', function($scope, Habits) {
  $scope.test = "test";
  $scope.save = Habits.save;
  $scope.habit = {};
});
