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
});
