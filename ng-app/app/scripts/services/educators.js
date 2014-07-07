'use strict';

// Factory for interacting with the rails educators api

angular.module('edumatcherApp').factory('Educators', ['$resource', function($resource) {
  return $resource('/educators/:id', {
    id: '@id'
  },
  {
    subjects: {
      method: 'GET',
      url: '/educators/:id/subjects',
      isArray: true
    }
  });
}]);
