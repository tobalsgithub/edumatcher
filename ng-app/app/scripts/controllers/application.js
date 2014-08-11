'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:AppCtrl
 * @description
 * # AppCtrl
 * Controller of the edumatcherApp
 */
// angular.module('edumatcherApp').config(['$provide', function ($provide) {
//   $provide.decorator('$rootScope', function ($delegate) {
//     var _emit = $delegate.$emit;
//
//     $delegate.$emit = function () {
//       console.log.apply(console, arguments);
//       _emit.apply(this, arguments);
//     };
//
//     return $delegate;
//   });
// }]);

angular.module('edumatcherApp')
  .controller('AppCtrl', function ($scope, $stateParams, $rootScope, Auth, $http, $location, $state, $animate, $window, webStorage, SchoolDistricts, Schools, Classrooms, Experts, Companies) {

    var empty_classroom = {
      name: null,
      website: null,
      location: null,
      notes: null
    };

    var empty_school = {
      name: null,
      website: null,
      location: null,
      notes: null
    };

    var empty_school_district = {
      name: null,
      website: null,
      location: null,
      notes: null
    };

    var empty_session = {
      school_district: null,
      school: null,
      classroom: null,
      user: null,
      expert: null
    };

    $scope.credentials = {email: null, password: null};
    $scope.user = {};
    $scope.attempted_url = '';
    $scope.login_failed_message = '';
    $scope.state = $state;
    $scope.session = empty_session;

    // login form stuff

      // hide error messages until 'submit' event
    $scope.submitted = false;

    // hide success message
    $scope.showMessage = false;

    // hide error message
    $scope.showErrorMessage = false;

    // method called from shakeThat directive
    $scope.submit = function() {
      // show success message
      $scope.showMessage = true;
    };

    $rootScope.$on('devise:unauthorized', function(event, xhr){
      $scope.unauthorized(event, xhr);
    });

    $rootScope.$on('devise:login', function(event, currentUser) {
      webStorage.add('user', currentUser);
      $scope.session.user = currentUser;
      var attemptedUrl = webStorage.get('attemptedUrl');
      if(attemptedUrl){
        $window.location.href = attemptedUrl;
      }else{
        if(currentUser.is_expert){
          $state.go('dashboards.experts.home');
        }else if(currentUser.is_educator){
          $state.go('dashboards.educators.home');
        }else if(currentUser.admin){
          $state.go('admin');
        }else {
          $state.go('index');
        }
      }
    });

    $rootScope.$on('devise:logout', function(event, oldCurrentUser) {
      $scope.clearSession();
    });

    $rootScope.$on('$stateChangeStart', function(event, toState, toParams, fromState, fromParams){
      var user = webStorage.get('user');
      if((toState.module === 'private' || toState.module === 'admin' ) && !user){
        event.preventDefault();
        webStorage.add('attemptedUrl', $window.location.href );
        $state.go('login');
      }else if(toState.module === 'admin' && !user.admin) {
        event.preventDefault();
        $state.go('index');
      }
    });

    $scope.clearSession = function(){
      webStorage.clear();
      $scope.session = empty_session;
    };

    $scope.unauthorized = function(event, xhr){
      var element;
      $scope.clearSession();

      if($state.current.name === 'login'){

        element = $('#loginForm');

        $scope.login_error_message = xhr.data.error;

        $scope.showErrorMessage = true;

        // shake that form
        $animate.addClass(element, 'shake', function() {
          $animate.removeClass(element, 'shake');
        });

      } else{

        webStorage.add('attemptedUrl', $window.location.href);

        $scope.promptLogin();
      }
    };

    $scope.promptLogin = function(){
      $state.go('login');
    };

    $scope.addClassroomToScope = function(){
      $scope.classroom = $scope.session.classroom;
    };

    $scope.addSchoolToScope = function(){
      $scope.school = $scope.session.school;
    };

    $scope.addSchoolDistrictToScope = function(){
      $scope.school_district = $scope.session.school_district;
    };

    $scope.newClassroom = function(){
      $scope.classroom = empty_classroom;
    };

    $scope.newSchool = function(){
      $scope.school = empty_school;
    };

    $scope.newSchoolDistrict = function(){
      $scope.school_district = empty_school_district;
    };

    $scope.setSchoolDistrict = function(id){
      var school_district = SchoolDistricts.get({id: id},function(){
        webStorage.add('school_district',school_district);
        $scope.session.school_district = school_district;
      });
    };

    $scope.setSchool = function(id){
      var school = Schools.get({id: id},function(){
        webStorage.add('school',school);
        $scope.session.school = school;
      });
    };

    $scope.setClassroom = function(id){
      var classroom = Classrooms.get({id: id},function(){
        webStorage.add('classroom',classroom);
        $scope.session.classroom = classroom;
      });
    };

    $scope.setExpert = function(id){
      var expert = Experts.get({id: id}, function(){
        webStorage.add('expert', expert);
        $scope.session.expert = expert;
      });
    };

    $scope.getSchoolDistricts = function(){
      SchoolDistricts.query(function(school_districts){
        $scope.school_districts = school_districts;
      });
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

    $scope.searchCompanies = function(searchText){
      return Companies.search(searchText, function(companies){
        return companies;
      });
    };

    $rootScope.$on('$stateChangeSuccess', function(event, toState, toParams){
      if(toParams.school_district_id && (!$scope.session.school_district || !$scope.session.school_district.id || $scope.session.school_district.id !== toParams.school_district_id)){
        $scope.setSchoolDistrict(toParams.school_district_id);
      }
      if(toParams.school_id && (!$scope.session.school || !$scope.session.school.id || $scope.session.school.id !== toParams.school_id)){
        $scope.setSchool(toParams.school_id);
      }
      if(toParams.classroom_id && (!$scope.session.classroom || !$scope.session.classroom.id || $scope.session.classroom.id !== toParams.classroom_id)){
        $scope.setClassroom(toParams.classroom_id);
      }
      if(toParams.expert_id && (!$scope.session.expert || !$scope.session.expert.id || $scope.session.expert.id !== toParams.expert_id )){
        $scope.setExpert(toParams.expert_id);
      }
    });

    function init(){
      $scope.session.school_district = webStorage.get('school_district');
      $scope.session.school = webStorage.get('school');
      $scope.session.classroom = webStorage.get('classroom');
      $scope.session.user = webStorage.get('user');
    }

    init();

  });
