var fs  = require('fs');
var gui = require('nw.gui');
var win = gui.Window.get();

angular.module('tasksTracker', ['ngRoute'])

.config(function($routeProvider) {
  $routeProvider
    .when('/', {
      controller: 'TaskListCtrl',
    templateUrl: 'templates/tasks.html'
    })

    .when('/new', {
      controller: 'CreateCtrl',
      templateUrl: 'templates/new.html'
    });
})

.service('Tasks', function() {
  this.values = {};
  this.count = 0;
  this.saveToJson = function(val) {
    var jfile = JSON.stringify(val);
    fs.writeFileSync("tasks.json", jfile);
  };
})

.controller('HeaderCtrl', function($scope) {
  $scope.close = function() {
    win.close();
  };
})

.controller('TaskListCtrl', function($scope, Tasks) {
  $scope.tasks = Tasks;
})

.controller('CreateCtrl', function($location, $scope, Tasks) {

  $scope.save = function() {
    t = $scope.task;
    Tasks.values[t.name.toLowerCase()] = t;
    Tasks.count += 1;
    Tasks.saveToJson(Tasks);
    $location.path('/');
  }
});
