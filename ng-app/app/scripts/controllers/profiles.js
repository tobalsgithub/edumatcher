'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:ProfilesCtrl
 * @description
 * # ProfilesCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('ProfilesCtrl', function ($scope, Classrooms, Schools, SchoolDistricts, Subjects, GradeLevels) {

    $scope.subjects = [];
    $scope.subject_list = [];
    $scope.grade_levels = [];
    $scope.grade_level_list = [];
    $scope.page = 1;
    $scope.limit = 10;

    function init(){
      $scope.subjects = Subjects.query();
      $scope.grade_levels = GradeLevels.query();
    }

    init();

  });
