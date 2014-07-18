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
    'mgcrea.ngStrap',
    'stateFiles'
  ])

  .config(['$stateProvider','$urlRouterProvider', function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/');

    $stateProvider

      // HOME STATES AND NESTED VIEWS ========================================
      .state('home', {
        url: '/',
        templateUrl: 'views/index.html',
        css: 'styles/home.css'
      })

      .state('login', {
        url: '/login',
        templateUrl: 'views/users/login_form.html',
        controller: 'UsersCtrl',
        css: ['styles/shake_that.css','styles/login.css'],
        js: 'scripts/flatui-checkbox.js1'
      })

      .state('register', {
        url: '/register',
        templateUrl: 'views/users/registration_form.html',
        controller: 'UsersCtrl',
        css: ['styles/shake_that.css','styles/register.css'],
      })

      .state('registration_confirmation', {
        url: '/registration_confirmation',
        templateUrl: 'views/users/registration_confirmation.html',
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

      .state('classrooms_create',{
        url: '/classrooms/create',
        templateUrl: 'views/classrooms/create.html'
        controller: 'ClassroomsCtrl'
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
