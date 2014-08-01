'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:AdminCtrl
 * @description
 * # AdminCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('AdminCtrl', function ($scope, $stateParams, $state, SchoolDistricts, Schools, Classrooms, Subjects, GradeLevels) {

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

    // $scope.create = function(){
    //   var school_district = new SchoolDistricts($scope.school_districts);
    //   //school_district.save();
    //   $scope.parent.school_district = school_district;
    //   $state.transitionTo('admin_schools_create');
    // };

    $scope.addClassroomToScope = function(){
      $scope.classroom = $scope.session.classroom;
    };

    $scope.addSchoolToScope = function(){
      $scope.school = $scope.session.school;
    };

    $scope.createSchool = function(){
      var school = new Schools($scope.school);
      school.school_district_id = $scope.session.school_district.id;
      school.$save();
      $state.go('admin_school_districts_schools_list', {school_district_id: $scope.session.school_district.id});
    };

    $scope.updateSchool = function(){
      Schools.update({id: $scope.school.id},$scope.school, function(){
        $scope.setSchool($scope.school.id);
      });
    };

    $scope.createClassroom = function(){
      var classroom = new Classrooms($scope.classroom);
      classroom.school_id = $scope.session.school.id;
      classroom.$save();
      $state.go('admin_schools_classrooms_list',{school_district_id: $scope.session.school_district.id, school_id: $scope.session.school.id});
    };

    $scope.updateClassroom = function(){
      Classrooms.update({id: $scope.classroom.id}, $scope.classroom, function(){
        $scope.setClassroom($scope.classroom.id);
      });
      $state.go('admin_classroom_detail',{school_district_id: $scope.session.school_district.id, school_id: $scope.session.school.id,classroom_id: $scope.session.classroom.id});
    };

    $scope.getSchools = function(){
      SchoolDistricts.schools({id: $scope.session.school_district.id}, function(schools){
        $scope.schools = schools;
        //$state.go('admin_school_districts_schools_list', {school_district_id: $scope.session.school_district.id});
      });
    };

    $scope.getClassrooms = function(){
      Schools.classrooms({id: $scope.session.school.id}, function(classrooms){
        $scope.classrooms = classrooms;
      });
    };

    function init(){
      $scope.school_districts = SchoolDistricts.query();
      //console.log($state.current);
    }

    init();

  });
