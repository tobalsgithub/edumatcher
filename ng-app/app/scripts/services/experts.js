'use strict';

// Factory for interacting with the rails experts api

angular.module('edumatcherApp').factory('Experts', ['$resource', function($resource) {
  return $resource('/experts/:id', {
    id: '@id'
  },
  {
    search: {
      method: 'GET',
      url: '/experts/search',
      isArray: true
    },
    subjects: {
      method: 'GET',
      url: '/experts/:id/subjects',
      isArray: true
    },
    add_subject: {
      method: 'PUT',
      url: '/experts/:id/add_subject'
    },
    remove_subject: {
      method: 'PUT',
      url: '/experts/:id/remove_subject'
    },
    set_subjects: {
      method: 'POST',
      url: '/experts/:id/set_subjects'
    }
  });
}]);
