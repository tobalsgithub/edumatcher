'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:ClassroomsCtrl
 * @description
 * # ClassroomsCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('ClassroomsCtrl', function ($scope, $http, Classrooms) {

    function init() {
      var classrooms = Classrooms.get({id: 1});
      console.log(classrooms);
    }

    init();

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
      distance: 25
    },{
      distance: 50
    },{
      distance: 100
    },{
      distance: 'Anywhere'
    }];

    $scope.subjects = [{
      name: 'Mathematics',
      id: 1
    },{
      name: 'General Science',
      id: 2
    },{
      name: 'Physics',
      id: 3
    },{
      name: 'History',
      id: 4
    },{
      name: 'Technology',
      id: 5
    },{
      name: 'Geology',
      id: 6
    },{
      name: 'Chemistry',
      id: 7
    },{
      name: 'Government',
      id: 8
    },{
      name: 'Economics',
      id: 9
    },{
      name: 'Political Science',
      id: 10
    },{
      name: 'Physical Education',
      id: 11
    },{
      name: 'Social Studies',
      id: 12
    }];

  });
