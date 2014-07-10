'use strict';

angular.module('edumatcherApp')

  .directive('shakeThat', ['$animate', function($animate) {

    return {
      require: '^form',
      scope: {
        submit: '&',
        submitted: '='
      },
      link: function(scope, element, attrs, form) {

        // listen on submit event
        element.on('submit', function() {

          // tell angular to update scope
          scope.$apply(function() {

            // everything ok -> call submit fn from controller
            if (form.$valid) {return scope.submit();}

            // show error messages on submit
            scope.submitted = true;

            // shake that form
            $animate.addClass(element, 'shake', function() {
              $animate.removeClass(element, 'shake');
            });

          });

        });

      }
    };

  }]);
