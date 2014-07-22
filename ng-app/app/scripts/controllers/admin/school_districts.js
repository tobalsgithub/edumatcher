'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:AdminSchoolDistrictsCtrl
 * @description
 * # AdminSchoolDistrictsCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('AdminSchoolDistrictsCtrl', function ($scope, Classrooms, Subjects, GradeLevels) {

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
