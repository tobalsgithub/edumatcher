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
    'ui.router',
    'Devise',
    //'google-maps',
    'mgcrea.ngStrap'
  ])
  .config(['$stateProvider','$urlRouterProvider', function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/');

    $stateProvider

      // HOME STATES AND NESTED VIEWS ========================================
      .state('home', {
        url: '/',
        templateUrl: 'views/index.html'
      })

      .state('login', {
        url: '/login',
        templateUrl: 'views/users/login.html',
        controller: 'UsersCtrl'
      })

      .state('classrooms', {
        url: '/classrooms',
        views: {
          '': {
            templateUrl: 'views/classrooms/classrooms.html',
            controller: 'ClassroomsCtrl'
          },
          'userSnippet@classrooms': {
            templateUrl: 'views/users/user_snippet.html',
            controller: 'UsersCtrl'
          }
        }

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

  }]);
