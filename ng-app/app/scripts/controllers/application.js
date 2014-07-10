'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:AppCtrl
 * @description
 * # AppCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('AppCtrl', function ($scope, Auth, $http, $location) {

    $scope.credentials = {email: null, password: null};
    $scope.user = {};

    // Authentication stuff

    $scope.$on('devise:unauthorized', function(event, xhr, deferred) {
      //console.log(xhr.data.error);
      // Ask user for login credentials

      $scope.prompt_login();

      Auth.login($scope.credentials).then(function() {
        // Successfully logged in.
        // Redo the original request.
        console.log('login');
        return $http(xhr.config);
      }).then(function(response) {
        // Successfully recovered from unauthorized error.
        // Resolve the original request's promise.
        console.log('success');
        deferred.resolve(response);
      }, function(error) {
        // There was an error.
        // Reject the original request's promise.
        console.log('error');
        deferred.reject(error);
        $scope.login_failed_message = error;
      });
    });


    $scope.login = function() {
      Auth.login($scope.credentials).then(function(user) {
          $scope.user = user;
          $location.path('/home');
        }, function(error) {
          // Authentication failed...
          $scope.login_failed_message = error;
        });

    };

    $scope.logout = function() {
      Auth.logout();
      $location.path('/');
    };

    $scope.prompt_login = function(){
      return true;
    };

  });
