'use strict';

// Factory for interacting with the rails grade_levels api

angular.module('edumatcherApp').factory('GradeLevels', ['$resource', function($resource) {
  return $resource('/grade_levels/:id', {
    id: '@id'
  });
}]);
