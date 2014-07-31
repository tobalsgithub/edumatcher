'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:AdminSchoolDistrictsCtrl
 * @description
 * # AdminSchoolDistrictsCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('AdminSchoolDistrictsCtrl', function ($scope, $state, SchoolDistricts, Schools, Classrooms, Subjects, GradeLevels) {

    $scope.school_district = {
      name: null,
      website: null,
      location: null,
      notes: null
    };
    $scope.subjects = [];
    $scope.classrooms = [];
    $scope.subject_list = [];
    $scope.grade_levels = [];
    $scope.grade_level_list = [];
    $scope.school_districts = [];
    $scope.page = 1;
    $scope.limit = 10;

    $scope.create = function(){
      var school_district = new SchoolDistricts($scope.school_districts);
      //school_district.save();
      $scope.parent.school_district = school_district;
      $state.transitionTo('admin_schools_create');
    };

    function init(){
      $scope.school_districts = SchoolDistricts.query();
    }

    $scope.select_school_district = function(id){
      $scope.set_school_district(id);
      $state.go('admin_school_districts_detail', {school_district_id: id});
    };

    $scope.select_school = function(id){
      $scope.set_school(id);
      $state.go('admin_school_detail', {school_id: id});
    };

    $scope.select_classroom = function(id){
      $scope.set_classroom(id);
      $state.go('admin_classroom_detail', {classroom_id: id});
    };

    $scope.get_schools = function(){
      SchoolDistricts.schools({id: $scope.session.school_district.id}, function(schools){
        $scope.schools = schools;
        //$state.go('admin_school_districts_schools_list', {school_district_id: $scope.session.school_district.id});
      });
    };

    $scope.get_classrooms = function(){
      Schools.classrooms({id: $scope.session.school.id}, function(classrooms){
        $scope.classrooms = classrooms;
      });
    };

    init();

  });
