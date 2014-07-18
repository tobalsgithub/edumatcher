'use strict';

describe('Controller: AppCtrl', function () {

  var $scope, $location, $controller, $http, $rootScope, $q, $window, ctrl, Auth, deferred;

  function createController() {
    return $controller('AppCtrl', {
      $scope: $scope,
      $window: $window,
      $http: $http,
      Auth: Auth
    });
  }

  // load the controller's module
  beforeEach(module('edumatcherApp'));

  beforeEach(module('MockFactories'));

  beforeEach(inject(function(_$location_, _$controller_, _$rootScope_, _$q_, _$window_, _$http_, _Auth_, $httpBackend ){
    $rootScope = _$rootScope_;
    $scope = $rootScope.$new();
    $controller = _$controller_;
    $location = _$location_;
    $window = _$window_;
    $q = _$q_;
    $http = _$http_;
    Auth = _Auth_;
    deferred = $q.defer();

    ctrl = createController();

    $httpBackend.whenGET('views/index.html').respond({});

  }));



  describe('$on devise:unauthorized', function(){

    beforeEach(function(){
      spyOn($scope, 'unauthorized').andCallThrough();
      $rootScope.$broadcast('devise:unauthorized');
    });

    it('should call $scope.unauthorized', function(){
      expect($scope.unauthorized).toHaveBeenCalled();
    });
  });

  describe('Function: $scope.unauthorized', function(){

    describe('when on the login form', function(){
      var xhr = {
        data: {
          error: 'heyo'
        }
      };
      beforeEach(function(){
        $scope.state.current.name = 'login';
        $scope.unauthorized(null, xhr);
      });

      it('should set $scope.login_failed_message and $scope.showErrorMessage', function(){
        expect($scope.login_failed_message).not.toEqual('');
        expect($scope.showErrorMessage).toBe(true);
      });

    });

    describe('when in the main application', function(){

      beforeEach(function(){
        spyOn($scope, 'prompt_login');
        $scope.state.transitionTo('classrooms');
        $scope.unauthorized();
      });

      it('should record the attempted_url in $scope.attempted_url', function(){
        expect($scope.attempted_url).not.toEqual('');
      });

      it('should call $scope.prompt_login', function(){
        expect($scope.prompt_login).toHaveBeenCalled();
      });

    });

  });

});
