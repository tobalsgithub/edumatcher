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
        spyOn($scope,'setState').andCallThrough();
        spyOn($scope,'setLocation').andReturn(true);


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

      it('it should redirect to $scope.attempted_url if set', function(){
        var url = 'http://localhost:9000/#!/classrooms';

        $scope.attempted_url = url;

        $scope.login();

        deferred.resolve(data);

        $scope.$root.$digest();

        expect($scope.setLocation).toHaveBeenCalledWith(url);

      });

      it('should redirect to home on success', function(){
        expect($scope.setState).toHaveBeenCalledWith('home');
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
      spyOn(Auth,'logout').andReturn({});

      spyOn($scope, 'setState').andCallThrough();

      $scope.logout();

      $scope.$root.$digest();
    });

    it('should call Auth.logout()', function(){

      expect(Auth.logout).toHaveBeenCalled();

    });

    it('should set the state to home', function(){

      expect($scope.setState).toHaveBeenCalledWith('home');
    });

  });

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
        $scope.setState('classrooms');
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
