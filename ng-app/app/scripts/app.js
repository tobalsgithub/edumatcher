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
    'mgcrea.ngStrap',
    'stateFiles',
    'webStorageModule',
    'xeditable'
  ])

  .run(function(editableOptions) {
    editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
  })

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

      .state('profiles', {
        url: '/profiles',
        abstract: true,
        template: '<div ng-include="\'views/includes/user_header.html\'"></div><ui-view/>',
        module: 'private'
      })

      .state('profiles.search',{
        url: '/search',
        abstract: true,
        template: '<ui-view/>',
        controller: 'SearchCtrl'
      })

      .state('profiles.search.classrooms', {
        url: '/classrooms',
        templateUrl: 'views/classrooms/search.html',
        data: {
          update_classrooms: true
        }
      })

      .state('profiles.search.experts', {
        url: '/experts',
        templateUrl: 'views/experts/search.html',
        data: {
          update_experts: true
        }
      })

      .state('profiles.experts', {
        url: '/experts',
        controller: 'ProfilesCtrl',
        template: '<ui-view/>'
      })

      .state('profiles.experts.detail', {
        url: '/:expert_id',
        templateUrl: '/views/experts/detail.html'
      })

      .state('profiles.school_districts', {
        url: '/school_districts',
        controller: 'ProfilesCtrl',
        template: '<ui-view/>'
      })

      .state('profiles.school_districts.detail',{
        url: '/:school_district_id',
        templateUrl: 'views/school_districts/detail.html'
      })

      .state('profiles.schools', {
        url: '/school_districts/:school_district_id/schools',
        controller: 'ProfilesCtrl',
        template: '<ui-view/>'
      })

      .state('profiles.schools.list', {
        url: '/list',
        templateUrl: 'views/schools/list.html'
      })

      .state('profiles.schools.detail',{
        url: '/:school_id',
        templateUrl: 'views/schools/detail.html'
      })

      .state('profiles.classrooms', {
        url: '/school_districts/:school_district_id/schools/:school_id/classrooms',
        controller: 'ProfilesCtrl',
        template: '<ui-view/>'
      })

      .state('profiles.classrooms.detail', {
        url: '/:classroom_id',
        templateUrl: 'views/classrooms/detail.html'
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
        templateUrl: 'views/admin/school_districts/index.html',
        module: 'admin'
      })

      .state('admin.school_districts.list', {
        url: '/list',
        templateUrl: 'views/admin/school_districts/list.html',
        module: 'admin'
      })

      .state('admin.school_districts.create', {
        url: '/create',
        templateUrl: 'views/admin/school_districts/create.html',
        module: 'admin'
      })

      .state('admin.school_districts.edit', {
        url: '/:school_district_id/edit',
        templateUrl: 'views/admin/school_districts/edit.html',
        module: 'admin'
      })

      .state('admin.school_districts.detail', {
        url: '/:school_district_id',
        templateUrl: '/views/admin/school_districts/detail.html',
        module: 'admin'
      })

      // Schools

      .state('admin.schools', {
        url: '/school_districts/:school_district_id/schools',
        templateUrl: 'views/admin/schools/index.html',
        module: 'admin'
      })

      .state('admin.schools.list', {
        url: '/list',
        templateUrl: 'views/admin/schools/list.html',
        module: 'admin'
      })

      .state('admin.schools.create', {
        url: '/create',
        templateUrl: 'views/admin/schools/create.html',
        module: 'admin'
      })

      .state('admin.schools.edit', {
        url: '/:school_id/edit',
        templateUrl: 'views/admin/schools/edit.html',
        module: 'admin'
      })

      .state('admin.schools.detail', {
        url: '/:school_id',
        templateUrl: '/views/admin/schools/detail.html',
        module: 'admin'
      })

      // Classrooms

      .state('admin.classrooms', {
        url: '/school_districts/:school_district_id/schools/:school_id/classrooms',
        templateUrl: 'views/admin/classrooms/index.html',
        module: 'admin'
      })

      .state('admin.classrooms.list', {
        url: '/list',
        templateUrl: 'views/admin/classrooms/list.html',
        module: 'admin'
      })

      .state('admin.classrooms.create', {
        url: '/create',
        templateUrl: 'views/admin/classrooms/create.html',
        module: 'admin'
      })

      .state('admin.classrooms.edit', {
        url: '/:classroom_id/edit',
        templateUrl: 'views/admin/classrooms/edit.html',
        module: 'admin'
      })

      .state('admin.classrooms.detail', {
        url: '/:classroom_id',
        templateUrl: '/views/admin/classrooms/detail.html',
        module: 'admin'
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
