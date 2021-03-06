'use strict';

// Factory for interacting with the rails school_districts api

angular.module('edumatcherApp').factory('SchoolDistricts', ['$resource', function($resource) {
  return $resource('/school_districts/:id', {
    id: '@id'
  },
  {
    update: {
      method: 'PUT'
    },
    schools: {
      method: 'GET',
      url: '/school_districts/:id/schools',
      isArray: true
    }
  });
}]);
