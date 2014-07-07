'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:ClassroomsCtrl
 * @description
 * # ClassroomsCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('ClassroomsCtrl', function ($scope, $http, Classrooms, Subjects, GradeLevels) {

    $scope.subjects = [];
    $scope.classrooms = [];
    $scope.subject_list = [];
    $scope.grade_levels = [];
    $scope.grade_level_list = [];
    $scope.page = 1;
    $scope.limit = 10;

    function init() {
      $scope.classrooms = Classrooms.search();
      $scope.subjects = Subjects.query();
      $scope.grade_levels = GradeLevels.query();
    }

    init();

    function search_params(){
      return {
        'subject_list[]': $scope.subject_list || [],
        'grade_level_list[]': $scope.grade_level_list || [],
        'page': $scope.page || 1,
        'limit': $scope.limit || 10
      };
    }

    $scope.$watch('subject_list', function(newValue, oldValue){
      if(newValue !== oldValue) {
        //$scope.classrooms = Classrooms.search({'subject_list[]': $scope.subject_list });
        $scope.classrooms = Classrooms.search(search_params());

      }
    });

    $scope.$watch('grade_level_list', function(newValue, oldValue){
      if(newValue !== oldValue) {
        $scope.classrooms = Classrooms.search(search_params());
      }
    });

    $scope.map = {
      center: {
        latitude: 39.9500,
        longitude: -75.1700
      },
      zoom: 12
    };

  //   var myLatlng = new google.maps.LatLng(39.9500,-75.1700);
  //   var mapOptions = {
  //     zoom: 12,
  //     center: myLatlng
  //   }
  //   var icons = {
  //     unselected: {
  //       icon: '../images/blueflag.png'
  //     },
  //     selected: {
  //       icon: '../images/greenflag.png'
  //     }
  //   };
  //
  //   var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  //
  //   var marker = new google.maps.Marker({
  //       position: myLatlng,
  //       map: map,
  //       title: 'School'
  //   });
  //   map.panBy(400,0);
  //
  // }

    $scope.within_distances = [{
      id: 1,
      distance: 25,
      name: '25 miles'
    },{
      id: 2,
      distance: 50,
      name: '50 miles'
    },{
      id: 3,
      distance: 100,
      name: '100 miles'
    },{
      id: 999,
      distance: '9999999',
      name: 'Anywhere'
    }];

  });
