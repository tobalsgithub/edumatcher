'use strict';

describe('Controller: ClassroomsCtrl', function () {

  var scope, Classrooms, Subjects, GradeLevels, controllerFactory, ctrl;

  function createController() {
    return controllerFactory('ClassroomsCtrl', {
      $scope: scope,
      Classrooms: Classrooms,
      Subjects: Subjects,
      GradeLevels: GradeLevels
    });
  }

  // load the controller's module
  beforeEach(module('edumatcherApp'));

  beforeEach(module('MockFactories'));

  beforeEach(inject(function($controller, $rootScope, _Classrooms_, _Subjects_, _GradeLevels_ ){
    scope = $rootScope.$new();

    Classrooms = _Classrooms_;
    Subjects = _Subjects_;
    GradeLevels = _GradeLevels_;

    controllerFactory = $controller;

    ctrl = createController();

  }));


  describe('Function: init', function(){

    beforeEach(function(){
      Classrooms.search.reset();
      Subjects.query.reset();
      GradeLevels.query.reset();
      createController();
    });

    it('should call Classrooms.search', function(){
      expect(Classrooms.search).toHaveBeenCalled();
    });

    it('shoud call Subjects.query', function(){
      expect(Subjects.query).toHaveBeenCalled();
    });

    it('should call GradeLevels.query', function(){
      expect(GradeLevels.query).toHaveBeenCalled();
    });

  });

  describe('Function: search_params', function(){

    var search_params;

    beforeEach(function(){
      scope.subject_list = [1,2,3];
      scope.grade_level_list = [];
      scope.page = 3;
      scope.limit = 5;
      search_params = scope.search_params();
    });

    it('should return the correct subject_list', function(){
      expect(search_params['subject_list[]']).toEqual([1,2,3]);
    });

    it('should return the correct grade_level_list', function(){
      expect(search_params['grade_level_list[]']).toEqual([]);
    });

    it('should return the correct page', function(){
      expect(search_params.page).toEqual(3);
    });

    it('should return the correct limit', function(){
      expect(search_params.limit).toEqual(5);
    });

  });

  xdescribe('Function: update_classroosm', function(){

    beforeEach(function(){
      Classrooms.search.reset();
      spyOn(scope,'search_params').andCallThrough();
      scope.update_classrooms(3,4); //values just have to be different
    });

    it('should call Classrooms.search', function(){
      expect(Classrooms.search).toHaveBeenCalledWith(scope.search_params());
    });

    it('should call function search_params', function(){
      expect(scope.search_params).toHaveBeenCalled();
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
