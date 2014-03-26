var gui = require('nw.gui');
var win = gui.Window.get();

angular.module('task-tracker', ['ngRoute'])

.config(function($routeProvider) {
  $routeProvider
    .when('/', {
      controller: 'TasksCtrl',
    templateUrl: 'templates/tasks.html'
    })

    .when('/new', {
      controller: 'CreateCtrl',
      templateUrl: 'templates/new.html'
    });
})

.service('Tasks', function() {
  this.values = [];
})

.controller('HeaderCtrl', function($scope) {
  $scope.close = function() {
    win.close();
  };
})

.controller('TasksCtrl', function($scope, Tasks) {
  $scope.tasks = Tasks;
  $scope.t = $scope.tasks.values;
})

.controller('CreateCtrl', function($location, $scope, Tasks) {

  $scope.tasks = Tasks;
  $scope.save = function() {
    $scope.tasks.values.push($scope.task);
    $location.path('/');
  }
});
