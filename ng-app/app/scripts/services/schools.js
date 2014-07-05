'use strict';

// Factory for interacting with the rails schos api

angular.module('edumatcherApp').factory('Schools', ['$resource', function($resource) {
  return $resource('/schools/:id', {
    id: '@id'
  });
}]);
