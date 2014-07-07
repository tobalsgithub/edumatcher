'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:ClassroomsCtrl
 * @description
 * # ClassroomsCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('ClassroomsCtrl', function ($scope, $http, Classrooms, Subjects) {

    $scope.subjects = [];
    $scope.classrooms = [];
    $scope.subject_list = [];

    function init() {
      $scope.classrooms = Classrooms.search();
      $scope.subjects = Subjects.query();
    }

    init();


    $scope.$watch('subject_list', function(newValue, oldValue){
      if(newValue !== oldValue) {
        $scope.classrooms = Classrooms.search({'subject_list[]': $scope.subject_list });
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

    $scope.find = function(){
      var data = {
        subject_list: $scope.subject_list,
        limit: $scope.limit,
        page: $scope.page
      };

      $http.post('/classrooms/search', data).success(function(data){
        $scope.classrooms = data;
      });
    };

    $scope.grade_level_list = [];

    $scope.grade_levels = [{
      name: 'Elementary',
      id: 1
    },{
      name: 'Middle School',
      id: 2
    },{
      name: 'High School',
      id: 3
    }];

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
