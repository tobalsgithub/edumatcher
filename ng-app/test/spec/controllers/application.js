'use strict';

describe('Controller: AppCtrl', function () {

  var $scope, $location, $controller, $rootScope, $q, ctrl, Auth, deferred;

  function createController() {
    return $controller('AppCtrl', {
      $scope: $scope,
      Auth: Auth
    });
  }

  // load the controller's module
  beforeEach(module('edumatcherApp'));

  beforeEach(module('MockFactories'));

  beforeEach(inject(function(_$location_, _$controller_, _$rootScope_, _$q_, _Auth_ ){
    $rootScope = _$rootScope_;
    $scope = $rootScope.$new();
    $controller = _$controller_;
    $location = _$location_;
    $q = _$q_;
    Auth = _Auth_;
    deferred = $q.defer();

    ctrl = createController();

  }));

  describe('function: login', function(){

    describe('success', function(){

      var data = {
        name: 'username',
        email: 'email@place.com',
        id: 5
      };

      beforeEach(function(){
        $scope.credentials = {
          email: 'hey@gmail.com',
          password: 'password'
        };

        deferred = $q.defer();

        spyOn(Auth, 'login').andReturn(deferred.promise);
        spyOn($location,'path').andCallThrough();

        $scope.login();

        deferred.resolve(data);

        $scope.$root.$digest();

      });

      it('should call Auth.login', function(){
        expect(Auth.login).toHaveBeenCalledWith($scope.credentials);
      });

      it('should set $scope.user on success', function(){
        expect($scope.user).toEqual(data);
      });

      it('should redirect to /home on success', function(){
        expect($location.path).toHaveBeenCalledWith('/home');
      });

    });

    describe('failure', function(){

      beforeEach(function(){

        spyOn(Auth, 'login').andReturn(deferred.promise);

        $scope.login();

        deferred.reject('error');

        $scope.$root.$digest();
      });

      it('should set $scope.login_failed_message on error', function(){
        expect($scope.login_failed_message).not.toBe(undefined);
      });

    });

  });

  describe('function: logout', function(){

    beforeEach(function(){
      spyOn(Auth,'logout').andReturn('');

      $scope.logout();

      $scope.$root.$digest();
    });

    it('should call Auth.logout()', function(){

      expect(Auth.logout).toHaveBeenCalled();

    });

    it('should redirect to /', function(){

      expect($location.path()).toBe('/');
    });

  });

  describe('$on devise:unauthorized', function(){

    beforeEach(function(){

    });

    it('should call $scope.prompt_login', function(){
      spyOn($scope, 'prompt_login');

      $rootScope.$broadcast('devise:unauthorized');

      expect($scope.prompt_login).toHaveBeenCalled();
    });

    it('should call Auth.login', function(){

      spyOn(Auth,'login').andReturn(deferred.promise);

      $rootScope.$broadcast('devise:unauthorized');

      expect(Auth.login).toHaveBeenCalled();

    });

    // I'm generally unsure how to test this part.
    xdescribe('successful login', function(){

      it('should redo the original request', function(){

      });

      it('should resolve the original request\'s promise', function(){

      });

    });

    describe('failed login', function(){

      it('should reject the original request\'s promise', function(){

      });

      it('should set $scope.login_failed_message on error', function(){
        expect($scope.login_failed_message).not.toBe(undefined);
      });

    });

  });


});
