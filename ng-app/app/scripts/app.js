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
    'ui.bootstrap',
    'Devise',
    //'google-maps',
    //'mgcrea.ngStrap',
    'stateFiles',
    'webStorageModule'
  ])

  .config(['$stateProvider','$urlRouterProvider', '$httpProvider', function ($stateProvider, $urlRouterProvider, $httpProvider) {
    $urlRouterProvider.otherwise('/');

    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');


    $stateProvider

      // HOME STATES AND NESTED VIEWS ========================================
      .state('index', {
        url: '/',
        templateUrl: 'views/index.html',
        css: 'styles/index.css',
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

      // Admin views

      .state('admin', {
        url: '/admin',
        templateUrl: 'views/admin/index.html',
        controller: 'AdminCtrl',
        module: 'admin'
      })

      // School Districts

      .state('admin.school_districts', {
        url: '/school_districts',
        templateUrl: 'views/admin/school_districts/index.html'
      })

      .state('admin.school_districts.list', {
        url: '/list',
        templateUrl: 'views/admin/school_districts/list.html'
      })

      .state('admin.school_districts.create', {
        url: '/create',
        templateUrl: 'views/admin/school_districts/create.html'
      })

      .state('admin.school_districts.edit', {
        url: '/:school_district_id/edit',
        templateUrl: 'views/admin/school_districts/edit.html'
      })

      .state('admin.school_districts.detail', {
        url: '/:school_district_id',
        templateUrl: '/views/admin/school_districts/detail.html'
      })

      // Schools

      .state('admin.schools', {
        url: '/school_districts/:school_district_id/schools',
        templateUrl: 'views/admin/schools/index.html'
      })

      .state('admin.schools.list', {
        url: '/list',
        templateUrl: 'views/admin/schools/list.html'
      })

      .state('admin.schools.create', {
        url: '/create',
        templateUrl: 'views/admin/schools/create.html'
      })

      .state('admin.schools.edit', {
        url: '/:school_id/edit',
        templateUrl: 'views/admin/schools/edit.html'
      })

      .state('admin.schools.detail', {
        url: '/:school_id',
        templateUrl: '/views/admin/schools/detail.html'
      })

      // Classrooms

      .state('admin.classrooms', {
        url: '/school_districts/:school_district_id/schools/:school_id/classrooms',
        templateUrl: 'views/admin/classrooms/index.html'
      })

      .state('admin.classrooms.list', {
        url: '/list',
        templateUrl: 'views/admin/classrooms/list.html'
      })

      .state('admin.classrooms.create', {
        url: '/create',
        templateUrl: 'views/admin/classrooms/create.html'
      })

      .state('admin.classrooms.edit', {
        url: '/:classroom_id/edit',
        templateUrl: 'views/admin/classrooms/edit.html'
      })

      .state('admin.classrooms.detail', {
        url: '/:classroom_id',
        templateUrl: '/views/admin/classrooms/detail.html'
      });



      // .state('main', {
      //   url: '/main',
      //   templateUrl: 'views/main.html'
      // })
      //
      // // ABOUT PAGE AND MULTIPLE NAMED VIEWS =================================
      // .state('about', {
      //   // we'll get to this in a bit
      //   url: '/about',
      //   templateUrl: 'views/about.html'
      // });

  }]);
