'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:LoginCtrl
 * @description
 * # LoginCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('UsersCtrl', function ($scope, Auth, $state, $window, Users) {

    $scope.new_user = {
      fullname: null,
      email: null,
      password: null,
      password_confirmation: null
    };

    $scope.user_types = {
      expert: {
        id: 1,
        prompt: 'I am an Expert'
      },
      educator: {
        id: 2,
        prompt: 'I am an Educator'
      }
    };

    $scope.state = $state; // pretty much just used for unit testing
    $scope.attempted_url = '';
    $scope.showErrorMessages = null;
    $scope.registration_error_messages = [];
    $scope.login_failed_messages = [];
    $scope.login_error_message = '';

    $scope.register = function(){
      Auth.register($scope.new_user).then(function(user){
        switch($scope.selected_user_type){
        case $scope.user_types.expert.id:
          Users.set_expert();
          break;
        case $scope.user_types.educator.id:
          Users.set_educator();
          break;
        }
        $state.transitionTo('registration_confirmation');
      }, function(response){
        // Registration failed...
        var i, errors = {};
        $scope.registration_error_messages = [];
        $scope.showErrorMessage = true;
        errors = response.data.errors;

        for(var key in errors){
          for(i=0; i<errors[key].length; i++){
            $scope.registration_error_messages.push(key + ' ' + errors[key][i]);
          }
        }
      });
    };


    $scope.login = function() {
      var url;

      Auth.login($scope.credentials).then(function(user) {
        // nothing at the moment. All handled by new-session event in application.js
      }, function(response) {
        // Authentication failed...
        $scope.showErrorMessages = true;
        $scope.login_error_message = response.error;
      });

    };

    $scope.logout = function() {
      Auth.logout();
      $state.go('index');
    };

    $scope.setLocation = function(url){
      $window.location.href = url;
    };

  });
