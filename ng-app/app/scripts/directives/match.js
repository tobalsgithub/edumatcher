'use strict';

angular.module('edumatcherApp').
  directive('match', function () {
    return {
      require: 'ngModel',
      restrict: 'A',
      scope: {
        match: '='
      },
      link: function(scope, elem, attrs, ngModel) {
        scope.$watch('match', function(){
          ngModel.$validate();
        });
        ngModel.$validators.match = function(modelValue, viewValue){
          var value = modelValue || viewValue;
          var match = scope.match;
          return value === match;
        };
      }
    };
  });
