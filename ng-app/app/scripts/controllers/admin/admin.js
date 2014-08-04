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

    $scope.subjects = [];
    $scope.subject_list = [];
    $scope.grade_levels = [];
    $scope.grade_level_list = [];
    $scope.page = 1;
    $scope.limit = 10;

    // $scope.create = function(){
    //   var school_district = new SchoolDistricts($scope.school_districts);
    //   //school_district.save();
    //   $scope.parent.school_district = school_district;
    //   $state.transitionTo('admin_schools_create');
    // };

    $scope.createSchoolDistrict = function(){
      var school_district = new SchoolDistricts($scope.school_district);
      school_district.$save();
      $state.go('admin_school_districts.list');
    };

    $scope.updateSchoolDistrict = function(){
      SchoolDistricts.update({id: $scope.school_district.id},$scope.school_district, function(){
        $scope.setSchoolDistrict($scope.school_district.id);
      });
      $state.go('admin.school_districts.detail', {school_district_id: $scope.school_district_id});
    };

    $scope.createSchool = function(){
      var school = new Schools($scope.school);
      school.school_district_id = $scope.session.school_district.id;
      school.$save(function(school){
        $scope.setSchool(school.id);
        $state.go('admin.schools.detail', {school_district_id: $scope.session.school_district.id, school_id: school.id});
      });
    };

    $scope.updateSchool = function(){
      Schools.update({id: $scope.school.id},$scope.school, function(){
        $scope.setSchool($scope.school.id);
      });
      $state.go('admin.schools.detail', { school_id: $scope.school.id});
    };

    $scope.createClassroom = function(){
      var classroom = new Classrooms($scope.classroom);
      classroom.school_id = $scope.session.school.id;
      classroom.save(function(classroom){
        $scope.setClassroom(classroom.id);
        $state.go('admin.classrooms.detail',{school_district_id: $scope.session.school_district.id, school_id: $scope.session.school.id, classroom_id: classroom.id});
      });
    };

    $scope.updateClassroom = function(){
      var classroom = new Classrooms($scope.classroom);
      classroom.save(function(classroom){
        $scope.setClassroom($scope.classroom.id);
      });
      // Classrooms.update({id: $scope.classroom.id}, $scope.classroom, function(classroom){
      //   $scope.setClassroom($scope.classroom.id);
      //   console.log(classroom);
      // });
      $state.go('admin.classrooms.detail',{school_district_id: $scope.session.school_district.id, school_id: $scope.session.school.id,classroom_id: $scope.session.classroom.id});
    };


    // $scope.searchSubjects = function(searchText) {
    //   if(!searchText || typeof searchText !== 'string'){ return; }
    //   var subjects = [];
    //   var i;
    //   searchText = searchText.toLowerCase();
    //   for(i=0;i<$scope.subject_list.length; i++){
    //     if($scope.subject_list[i].name.toLowerCase().indexOf(searchText) >=0 ) {
    //       subjects.push($scope.subject_list[i]);
    //     }
    //   }
    //   return subjects;
    // };

    $scope.addSubjectToClassroom = function(item){
      if(!$scope.classroom.subjects){
        $scope.classroom.subjects = [];
      }else if($.grep($scope.classroom.subjects, function(sub){ return sub.id === item.id; }).length > 0){
        return;
      }
      $scope.classroom.subjects.push(item);
      $scope.subject = '';
      console.log($scope.classroom.subjects);
    };

    $scope.removeSubjectFromClassroom = function(subject){
      $scope.classroom.subjects = $.grep($scope.classroom.subjects, function(sub){ return sub.id !== subject.id;});

    };

    function init(){
      $scope.subject_list = Subjects.query();
      //console.log($state.current);
    }

    init();

  });
