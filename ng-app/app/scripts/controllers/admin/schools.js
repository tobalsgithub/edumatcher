'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:AdminSchoolsCtrl
 * @description
 * # AdminSchoolsCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('AdminSchoolsCtrl', function ($scope, Classrooms, Subjects, GradeLevels) {

    $scope.subjects = [];
    $scope.classrooms = [];
    $scope.subject_list = [];
    $scope.grade_levels = [];
    $scope.grade_level_list = [];
    $scope.page = 1;
    $scope.limit = 10;



    function init(){

    }

    init();

  });
