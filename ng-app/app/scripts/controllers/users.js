'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:LoginCtrl
 * @description
 * # LoginCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('UsersCtrl', function ($scope, $http, Auth) {

    $scope.credentials = {email: null, password: null};

    // Authentication stuff

    $scope.$on('devise:unauthorized', function(event, xhr, deferred) {
      //console.log(xhr.data.error);
      // Ask user for login credentials
      console.log('devise:unauthorized');
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
      });
    });


    $scope.login = function() {
      Auth.login($scope.credentials).then(function(user) {
          console.log(user); // => {id: 1, ect: '...'}
        }, function(error) {
          // Authentication failed...
          console.log('err' + error);
        });
    //   console.log($scope.login_user);
    //   $http.post('/users/sign_in.json', {user: {email: $scope.login_user.email, password: $scope.login_user.password}});
    // };
    };

    $scope.logout = function() {
      //$http({method: 'DELETE', url: '../users/sign_out.json', data: {}});
      Auth.logout();
    };
  });
