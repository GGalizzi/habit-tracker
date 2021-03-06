var fs  = require('fs');
var gui = require('nw.gui');
var win = gui.Window.get();

angular.module('habitsTrackerApp', [
    'ngRoute',
    'ngAnimate',
    'habitsTrackerApp.controllers',
    'habitsTrackerApp.services',
    'habitsTrackerApp.directives'
])

.config(function($routeProvider) {
  $routeProvider
    .when('/', {
      controller: 'HabitListCtrl',
      templateUrl: 'templates/habits.html'
    })

    .when('/new', {
      controller: 'CreateCtrl',
      templateUrl: 'templates/new.html'
    });
})

.constant('LevelConstants',  {
  PointsPerSuccess: 240,
  PointsPerFail: -300,
  PointsNeeded: function(level) {
    return 800+200*level;
  }
});
