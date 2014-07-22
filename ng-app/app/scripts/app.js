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

      .state('admin_school_districts_create', {
        url: '/admin/school_districts/create',
        templateUrl: 'views/school_districts/create.html',
        controller: 'AdminSchoolDistrictsCtrl',
        css: ['styles/shake_that.css']
      })

      .state('admin_schools_create', {
        url: '/admin/schools/create',
        templateUrl: 'views/schools/create.html',
        controller: 'AdminSchoolsCtrl',
        css: ['styles/shake_that.css']
      })

      .state('admin_classrooms_create',{
        url: '/admin/classrooms/create',
        templateUrl: 'views/classrooms/create.html',
        controller: 'AdminClassroomsCtrl',
        css: ['styles/shake_that.css']
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
