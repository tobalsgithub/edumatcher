'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:ReviewsCtrl
 * @description
 * # ReviewsCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('ReviewsCtrl', function ($scope, $state, Reviews) {

    $scope.reviews = [];

    $scope.review = {
      rating: null,
      title: null,
      notes: null
    };

    $scope.show_rating_message = false;

    $scope.createReview = function(){
      if($scope.review.rating === undefined || $scope.review.rating === null){
        $scope.show_rating_message = true;
        return;
      }
      var review = new Reviews($scope.review);
      if($state.current.data.reviewable_type === 'Expert'){
        review.reviewable_type = 'Expert';
        review.reviewable_id = $scope.session.expert.id;
      }else{
        return; // should never happen
      }
      review.save(function(review){
        $scope.reviews.push(review);
        console.log($scope.reviews);
        $state.go('dashboards.educators.reviews.list');
      });
      $scope.show_rating_message = false;
    };

    function init(){
      //$scope.reviews = Reviews.query();
    }

    init();

  });
