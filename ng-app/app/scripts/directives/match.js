'use strict';

angular.module('edumatcherApp').
  directive('inputMatch', function () {
    return {
      require: 'ngModel',
      restrict: 'A',
      scope: {
        match: '='
      },
      link: function(scope, elem, attrs, ngModel) {
        scope.$watch('match', function(){
          console.log('hey');
          ngModel.$validate();
        });
        ngModel.$validators.match = function(modelValue, viewValue){
          var value = modelValue || viewValue;
          var match = scope.match;
          console.log(scope.match);
          return value === match;
        };
      }
    };
  });
