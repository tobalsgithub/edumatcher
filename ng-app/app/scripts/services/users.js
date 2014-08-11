'use strict';

// Factory for interacting with the rails users api

angular.module('edumatcherApp').factory('Users', ['$resource', function($resource) {
  return $resource('/users/:id', {
    id: '@id'
  },
  {
    submitted_reviews: {
      method: 'GET',
      url: '/users/:id/submitted_reviews',
      isArray: true
    },
    set_expert: {
      method: 'POST',
      url: '/users/:id/set_expert'
    },
    set_educator: {
      method: 'POST',
      url: '/users/:id/set_educator'
    }
  });
}]);
