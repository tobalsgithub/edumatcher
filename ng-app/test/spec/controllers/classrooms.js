'use strict';

describe('Controller: SchoolDistrictsCtrl', function () {

  // load the controller's module
  beforeEach(angular.mock.module('edumatcherApp'));

  xit('should have a SchoolDistricts controller', function(){
    expect(edumatcherApp.SchoolDistrictsCtrl).toBeDefined();
  });

  var SchoolDistrictsCtrl, scope, httpBackend, http;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope, $httpBackend, $http) {
    scope = $rootScope.$new();
    httpBackend = $httpBackend;
    SchoolDistrictsCtrl = $controller('SchoolDistrictsCtrl', {
      $scope: scope,
      $http: $http
    });
  }));

  xdescribe('scope.create', function(){

    var validSchoolDistricts = [
        {
          name: 'School district',
          website: 'http://www.google.com',
          location: '123 I love it lane'
        }
    ];

    var invalidSchoolDistricts = [
      {
        name: '',
        website: 'http://someplace.anotherplace.com',
        location: 'yo yo I\'m a place'
      }
    ];

    it('should validate that a name is present', function(){

    });

    it('should create and return a new SchoolDistrict object', function(){

    });

    it('should change the path location', function(){

    });

  });

  describe('scope.search', function(){

    it('should add classrooms to the scope', function(){
      expect(scope.classrooms).be.undefined;
      scope.limit = 10;
      scope.page = 1;
      scope.subject_list = [1,2,3];

    });

  });

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).to.equal(3);
  });

});
