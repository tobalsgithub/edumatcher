'use strict';

// Factory for interacting with the rails subjects api

angular.module('edumatcherApp').factory('Subjects', ['$resource', function($resource) {
  return $resource('/subjects/:id', {
    id: '@id'
  });
}]);
