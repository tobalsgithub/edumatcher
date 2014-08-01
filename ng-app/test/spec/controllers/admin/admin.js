'use strict';

describe('Controller: AdminCtrl', function () {

  var scope, state, SchoolDistricts, Schools, Classrooms, Subjects, GradeLevels, controllerFactory, ctrl;

  var validSchoolDistrict = {
    name: 'School District',
    website: 'http://schooldistrict.com',
    notes: 'I good place'
  }

  var validSchool = {
    name: 'A school',
    website: 'Another school',
    notes: 'I\'m here'
  };

  var validClassroom = {
    name: 'Classroom',
    notes : 'Learn some stuff'
  };

  function createController() {
    return controllerFactory('AdminCtrl', {
      $scope: scope,
      $state: state,
      SchoolDistricts: SchoolDistricts,
      Schools: Schools,
      Classrooms: Classrooms,
      Subjects: Subjects,
      GradeLevels: GradeLevels
    });
  }
  // load the controller's module
  beforeEach(module('edumatcherApp'));

  //beforeEach(module('MockFactories'));

  beforeEach(inject(function($controller, $rootScope, $state, _SchoolDistricts_, _Schools_, _Classrooms_, _Subjects_, _GradeLevels_ ){
    scope = $rootScope.$new();
    scope.setSchoolDistrict = function(){};
    state = $state;

    SchoolDistricts = _SchoolDistricts_;
    Schools = _Schools_;
    Classrooms = _Classrooms_;
    Subjects = _Subjects_;
    GradeLevels = _GradeLevels_;

    controllerFactory = $controller;

    ctrl = createController();

    scope.session = {
      school_district: {
        name: null,
        website: null,
        location: null,
        notes: null
      },
      school: {
        name: null,
        website: null,
        location: null,
        notes: null
      },
      classroom: {
        name: null,
        website: null,
        location: null,
        notes: null
      }
    };

  }));

  describe('Function: createSchoolDistrict', function(){

    beforeEach(function(){
      //spyOn(Schools,'$save').andReturn(null);
      spyOn(state, 'go');
      scope.session.school_district = validSchoolDistrict;
      scope.school_district = validSchoolDistrict;
      scope.createSchoolDistrict();
    });

    xit('should call $save on the new school', function(){
      expect(SchoolDistricts.$save).toHaveBeenCalled();
    });

    it('shold call $state.go', function(){
      expect(state.go).toHaveBeenCalled();
    });

  });

  describe('Function: updateSchoolDistrict', function(){

    beforeEach(function(){
      spyOn(SchoolDistricts,'update').andReturn(null);
      spyOn(scope,'setSchoolDistrict');
      scope.school_district = validSchoolDistrict;
      scope.updateSchoolDistrict();
    });

    it('should call SchoolDistricts.update', function(){
      expect(SchoolDistricts.update).toHaveBeenCalled();
    });

    //scope.setSchoolDistrict is actually inheritd, so not sure how to test this
    // since the parent controller isn't present here.
    it('should call scope.setSchoolDistrict', function(){
      expect(scope.setSchoolDistrict).toHaveBeenCalled();
    });
  });

  describe('Function: createSchool', function(){

    beforeEach(function(){
      //spyOn(Schools,'$save').andReturn(null);
      spyOn(state, 'go');
      scope.session.school_district = validSchoolDistrict;
      scope.session.school = validSchool;
      scope.school = validSchool;
      scope.createSchool();
    });

    xit('should call $save on the new school', function(){
      expect(Schools.$save).toHaveBeenCalled();
    });

    it('shold call $state.go', function(){
      expect(state.go).toHaveBeenCalled();
    });

  });

  describe('Function: updateSchool', function(){

    beforeEach(function(){
      spyOn(Schools,'update').andReturn(null);
      scope.school = validSchool;
      scope.updateSchool();
    });

    it('should call Schools.update', function(){
      expect(Schools.update).toHaveBeenCalled();
    });
  });

  describe('Function: createClassroom', function(){

    beforeEach(function(){
      //spyOn(Schools,'$save').andReturn(null);
      spyOn(state, 'go');
      scope.session.school_district = validSchoolDistrict;
      scope.session.school = validSchool;
      scope.school = validSchool;
      scope.classroom = validClassroom;
      scope.createClassroom();
    });

    xit('should call $save on the new school', function(){
      expect(Classrooms.$save).toHaveBeenCalled();
    });

    it('shold call $state.go', function(){
      expect(state.go).toHaveBeenCalled();
    });

  });

  describe('Function: updateClassroom', function(){

    beforeEach(function(){
      spyOn(Classrooms,'update').andReturn(null);
      scope.classroom = validSchool;
      scope.updateClassroom();
    });

    it('should call Classrooms.update', function(){
      expect(Classrooms.update).toHaveBeenCalled();
    });
  });

  xdescribe('Scope: classrooms', function(){

    beforeEach(function(){
      Classrooms.search.reset();
      spyOn(scope, 'update_classrooms').andCallThrough();
    });

    it('should call update_classrooms when scope.subject_list changes', function(){
      scope.$digest();
      scope.subject_list.push(1);
      scope.$digest();
      expect(scope.update_classrooms).toHaveBeenCalled();
    });

    it('should call update_classrooms when scope.grade_level changes', function(){
      scope.$digest();
      scope.grade_level_list.push(2);
      scope.$digest();
      expect(Classrooms.search).toHaveBeenCalled();
    });

  });

});
