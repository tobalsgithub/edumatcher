'use strict';

describe('Controller: UsersCtrl', function () {

  var $scope, $controller, $rootScope, $q, ctrl, Auth, deferred, $state, $window, Users;

  function createController() {
    return $controller('UsersCtrl', {
      $scope: $scope,
      Auth: Auth,
      $state: $state,
      $window: $window,
      Users: Users
    });
  }

  // load the controller's module
  beforeEach(module('edumatcherApp'));

  beforeEach(module('MockFactories'));

  beforeEach(inject(function(_$controller_, _$rootScope_, _$q_, _Auth_, $httpBackend, _$state_, _$window_, _Users_){
    $rootScope = _$rootScope_;
    $scope = $rootScope.$new();
    $controller = _$controller_;
    $q = _$q_;
    Auth = _Auth_;
    $state = _$state_;
    $window = _$window_;
    Users = _Users_;
    deferred = $q.defer();

    ctrl = createController();

    $httpBackend.whenGET('views/index.html').respond({});

  }));

  describe('Function: register', function(){

    describe('success', function(){

      var data = {
        name: 'username',
        email: 'email@place.com',
        id: 5
      };

      beforeEach(function(){

        spyOn(Auth, 'register').andReturn(deferred.promise);
        spyOn($state,'go').andReturn({});

        $scope.register();

      });

      it('should call Auth.register', function(){
        deferred.resolve(data);
        $scope.$root.$digest();
        expect(Auth.register).toHaveBeenCalled();
      });

      it('should redirect to registration_confirmation', function(){
        deferred.resolve(data);
        $scope.$root.$digest();
        expect($state.go).toHaveBeenCalledWith('registration_confirmation');
      });

      it('should set the user type to expert if selected_user_type is expert', function(){
        $scope.selected_user_type = 1;
        deferred.resolve(data);
        $scope.$root.$digest();
        expect(Users.set_expert).toHaveBeenCalled();
      });

      it('should set the user type to educator if selected_user_type is educator', function(){
        $scope.selected_user_type = 2;
        deferred.resolve(data);
        $scope.$root.$digest();
        expect(Users.set_educator).toHaveBeenCalled();
      });

    });

    describe('failure', function(){

      var response = {
        data: {
          errors: {
            email: ['has already been taken'],
            password: ['is too short (minimum is 8 characters)']
          }
        }
      };

      beforeEach(function(){

        spyOn(Auth, 'register').andReturn(deferred.promise);

        $scope.register();

        deferred.reject(response);

        $scope.$root.$digest();
      });

      it('should set $scope.registration_failed_messages on error', function(){
        expect($scope.registration_error_messages.length).toEqual(2);
      });

      it('should set $scope.showErrorMessages to true', function(){
        expect($scope.showErrorMessage).toBe(true);
      });

    });

  });


  describe('function: login', function(){

    describe('success', function(){

      var data = {
        name: 'username',
        email: 'email@place.com',
        id: 5
      };

      beforeEach(function(){

        spyOn(Auth, 'login').andReturn(deferred.promise);
        spyOn($state,'go').andCallThrough();
        spyOn($scope,'setLocation').andReturn(true);


        $scope.login();

        deferred.resolve(data);

        $scope.$root.$digest();

      });

      it('should call Auth.login', function(){
        expect(Auth.login).toHaveBeenCalledWith($scope.credentials);
      });

    });

    describe('failure', function(){

      var response = {
        error: ['Incorrect email or password']
      };

      beforeEach(function(){

        spyOn(Auth, 'login').andReturn(deferred.promise);

        $scope.login();

        deferred.reject(response);

        $scope.$root.$digest();
      });

      it('should set $scope.login_failed_messages on error', function(){
        expect($scope.login_error_message).not.toEqual('');
      });

    });

  });

  describe('function: logout', function(){

    beforeEach(function(){
      spyOn(Auth,'logout').andReturn({});

      spyOn($state, 'go').andCallThrough();

      $scope.logout();

      $scope.$root.$digest();
    });

    it('should call Auth.logout()', function(){

      expect(Auth.logout).toHaveBeenCalled();

    });

    it('should set the state to home', function(){

      expect($state.go).toHaveBeenCalledWith('home');
    });

  });

});
