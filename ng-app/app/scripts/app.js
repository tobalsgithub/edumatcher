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
    'stateFiles',
    'webStorageModule'
  ])

  .config(['$stateProvider','$urlRouterProvider', '$httpProvider', function ($stateProvider, $urlRouterProvider, $httpProvider) {
    $urlRouterProvider.otherwise('/');

    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');


    $stateProvider

      // HOME STATES AND NESTED VIEWS ========================================
      .state('home', {
        url: '/',
        templateUrl: 'views/index.html',
        css: 'styles/home.css',
        module: 'public'
      })

      .state('login', {
        url: '/login',
        templateUrl: 'views/users/login_form.html',
        controller: 'UsersCtrl',
        css: ['styles/shake_that.css','styles/login.css'],
        js: 'scripts/flatui-checkbox.js1',
        module: 'public'
      })

      .state('register', {
        url: '/register',
        templateUrl: 'views/users/registration_form.html',
        controller: 'UsersCtrl',
        css: ['styles/shake_that.css','styles/register.css'],
        module: 'public'
      })

      .state('registration_confirmation', {
        url: '/registration_confirmation',
        templateUrl: 'views/users/registration_confirmation.html',
        controller: 'UsersCtrl',
        module: 'private'
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
        },
        module: 'private'
      })

      .state('admin_school_districts_list', {
        url: '/admin/school_districts',
        templateUrl: 'views/admin/school_districts_list.html',
        controller: 'AdminCtrl',
        module: 'admin'
      })

      .state('admin_school_districts_detail', {
        url: '/admin/school_districts/:school_district_id',
        templateUrl: 'views/admin/school_districts_detail.html',
        controller: 'AdminCtrl',
        module: 'admin'
      })

      .state('admin_school_districts_schools_list', {
        url: '/admin/school_districts/:school_district_id/schools',
        templateUrl: 'views/admin/schools_list.html',
        controller: 'AdminCtrl',
        module: 'admin'
      })

      .state('admin_school_districts_create', {
        url: '/admin/school_districts/create',
        templateUrl: 'views/admin/school_districts_create.html',
        controller: 'AdminCtrl',
        css: ['styles/shake_that.css'],
        module: 'admin'
      })

      .state('admin_school_districts_edit', {
        url: '/admi/school_districts/:school_district_id/edit',
        templateUrl: 'views/admin/school_districts_edit.html',
        controller: 'AdminCtrl',
        css: ['styles/shake_that.css'],
        module: 'admin'
      })

      .state('admin_schools_create', {
        url: '/admin/school_districts/:school_district_id/schools/create',
        templateUrl: 'views/admin/schools_create.html',
        controller: 'AdminCtrl',
        css: ['styles/shake_that.css'],
        module: 'admin'
      })

      .state('admin_school_detail', {
        url: '/admin/school_districts/:school_district_id/schools/:school_id',
        templateUrl: 'views/admin/schools_detail.html',
        controller: 'AdminCtrl',
        module: 'admin'
      })

      .state('admin_schools_edit',{
        url: '/admin/school_districts/:school_district_id/schools/:school_id/edit',
        templateUrl: 'views/admin/schools_edit.html',
        controller: 'AdminCtrl',
        css: ['styles/shake_that.css'],
        module: 'admin'
      })

      .state('admin_schools_classrooms_list', {
        url: '/admin/school_districts/:school_district_id/schools/:school_id/classrooms',
        templateUrl: 'views/admin/classrooms_list.html',
        controller: 'AdminCtrl',
        module: 'admin'
      })

      .state('admin_classrooms_create',{
        url: '/admin/school_districts/:school_district_id/schools/:school_id/classrooms/create',
        templateUrl: 'views/admin/classrooms_create.html',
        controller: 'AdminCtrl',
        css: ['styles/shake_that.css'],
        module: 'admin'
      })

      .state('admin_classroom_detail', {
        url: '/admin/school_districts/:school_district_id/schools/:school_id/classrooms/:classroom_id',
        templateUrl: 'views/admin/classrooms_detail.html',
        controller: 'AdminCtrl',
        module: 'admin'
      })

      .state('admin_classrooms_edit',{
        url: '/admin/school_districts/:school_district_id/schools/:school_id/classrooms/:classroom_id/edit',
        templateUrl: 'views/admin/classrooms_edit.html',
        controller: 'AdminCtrl',
        css: ['styles/shake_that.css'],
        module: 'admin'
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
