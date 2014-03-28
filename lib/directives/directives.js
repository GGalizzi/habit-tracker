angular.module('habitsTrackerApp.directives', ['habitsTrackerApp.services'])

.directive('unique', function(Habits) {
  return {
    require: 'ngModel',
    link: function(scope, elem, attrs, ctrl) {
      var validator = function(value) {
        console.log(scope);
        if(Habits.values[value.toLowerCase()]) {
          ctrl.$setValidity('unique', false);
          scope.uniqueError = true;
          return undefined;
        } else {
          ctrl.$setValidity('unique', true);
          return value;
        }
      };
      
      ctrl.$formatters.unshift(validator);
      ctrl.$parsers.unshift(validator);

      /*
      attrs.$observe('unique', function() {
        validator(ctrl.$viewValue);
      });
      */
    }
  };
})

.directive('htHabit', function() {
  return {
    restrict: 'A',
    transclude: true
  };
})

.directive('htDelete', function() {
  return {
    restrict: 'A',
    transclude: true,
    link: function(scope, elem, attrs) {
      elem.bind('click', function() {
        scope.$apply(function() {
          scope.action = "delete";
        });
      });
    }
  };
})

.directive('htConfirm', function() {
  return {
    restrict: 'A',
    transclude: true,
    link: function(scope, elem, attrs) {
      elem.bind('click', function() {
        if(scope.action === "delete" && attrs.class === "confirm") {
          scope.deleteHabit(scope);
        }
        scope.$apply(function() {
          scope.action = "index";
        });
      });
    }
  };
});
