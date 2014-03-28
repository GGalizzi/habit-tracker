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

  $scope.setEdit = function(habit) {
    $scope.newHabit = Object.create(habit);
    return $scope.newHabit.name;
  };

  $scope.editHabit = Habits.editHabit;

  $scope.action =  { list: "index" };
  $scope.actionElement = "show";
})

.controller('CreateCtrl', function($scope, Habits) {
  $scope.save = Habits.save;
  $scope.habit = {};
});
