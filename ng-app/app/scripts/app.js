'use strict';

/**
 * @ngdoc overview
 * @name edumatcherApp
 * @description
 * # edumatcherApp
 *
 * Main module of the application.
 */
angular
  .module('edumatcherApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngTouch',
    'ui.router'
  ])
  .config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/');

     $stateProvider

        // HOME STATES AND NESTED VIEWS ========================================
        .state('home', {
            url: '/',
            templateUrl: 'views/index.html'
        })

        .state('main', {
          url: '/main',
          templateUrl: 'views/main.html'
        })

        // ABOUT PAGE AND MULTIPLE NAMED VIEWS =================================
        .state('about', {
            // we'll get to this in a bit
            url: '/about',
            templateUrl: 'views/about.html'
        });

    // $routeProvider
    //   .when('/', {
    //     templateUrl: 'views/main.html',
    //     controller: 'MainCtrl'
    //   })
    //   .when('/about', {
    //     templateUrl: 'views/about.html',
    //     controller: 'AboutCtrl'
    //   })
    //   .otherwise({
    //     redirectTo: '/'
    //   });
  });
