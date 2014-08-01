'use strict';

angular.module('MockFactories',[]).
  factory('Classrooms', function(){
    return jasmine.createSpyObj('ClassroomsStub', [
      'get','$save','query','$remove','$delete','search', 'subjects', 'add_subject', 'remove_subject', 'set_subjects'
    ]);
  }).
  factory('Schools', function(){
    return jasmine.createSpyObj('SchoolsStub', [
      'get', '$save', 'query', '$remove', '$delete'
    ]);
  }).
  factory('SchoolDistricts', function(){
    return jasmine.createSpyObj('SchoolDistrictsStub', [
      'get', 'save', 'query', 'remove', 'delete'
    ]);
  }).
  factory('Experts', function(){
    return jasmine.createSpyObj('ExpertsStub', [
      'get', 'save', 'query', 'remove', 'delete', 'search', 'subjects', 'add_subject', 'remove_subject', 'set_subjects'
    ]);
  }).
  factory('Educators', function(){
    return jasmine.createSpyObj('EducatorsStub', [
      'get', 'save', 'query', 'remove', 'delete', 'subjects'
    ]);
  }).
  factory('GradeLevels', function(){
    return jasmine.createSpyObj('GradeLevelsStub', [
      'get', 'save', 'query', 'remove', 'delete'
    ]);
  }).
  factory('Subjects', function(){
    return jasmine.createSpyObj('SubjectsStub', [
      'get', 'save', 'query', 'remove', 'delete'
    ]);
  }).
  factory('Users', function(){
    return jasmine.createSpyObj('UsersStub', [
      'get', 'save', 'query', 'remove', 'delete', 'set_expert', 'set_educator'
    ]);
  });
