'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:AppCtrl
 * @description
 * # AppCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('AppCtrl', function ($scope, Auth, $http, $location, $state, $animate, $window) {

    $scope.credentials = {email: null, password: null};
    $scope.user = {};
    $scope.attempted_url = '';
    $scope.login_failed_message = '';
    $scope.state = $state;

    // login form stuff

      // hide error messages until 'submit' event
    $scope.submitted = false;

    // hide success message
    $scope.showMessage = false;

    // hide error message
    $scope.showErrorMessage = false;

    // method called from shakeThat directive
    $scope.submit = function() {
      // show success message
      $scope.showMessage = true;
    };

    $scope.$on('devise:unauthorized', function(event, xhr){
      $scope.unauthorized(event, xhr);
    });

    $scope.unauthorized = function(event, xhr){
      var element;

      if($state.current.name === 'login'){

        element = $('#loginForm');

        $scope.login_failed_message = xhr.data.error;

        $scope.showErrorMessage = true;

        // shake that form
        $animate.addClass(element, 'shake', function() {
          $animate.removeClass(element, 'shake');
        });

      } else {

        $scope.attempted_url = $window.location.href;

        $scope.prompt_login();
      }
    };

    $scope.login = function() {
      var url;
      Auth.login($scope.credentials).then(function(user) {

          $scope.user = user;

          if($scope.attempted_url !== ''){

            url = $scope.attempted_url;

            $scope.attempted_url = '';

            $scope.setLocation(url);

          } else {

            $scope.setState('home');

          }

        }, function(error) {
          // Authentication failed...
          $scope.showErrorMessage = true;
          $scope.login_failed_message = error;
        });

    };

    $scope.logout = function() {
      Auth.logout();
      $scope.setState('home');
    };

    $scope.prompt_login = function(){
      $scope.setState('login');
    };

    $scope.setState = function (path) {
      $state.transitionTo(path);
    };

    $scope.setLocation = function(url){
      $window.location.href = url;
    };

  });
