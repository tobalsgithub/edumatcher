'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('MainCtrl', function ($scope, $http) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];

    $scope.proxyTest = function(){
			$http.get('/welcome/proxy_test').success(function(data){
				console.log(data);
			});
    };
  });
