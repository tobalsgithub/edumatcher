'use strict';

// Factory for interacting with the rails classrooms api

angular.module('edumatcherApp').factory('Classrooms', ['$resource', function($resource) {
	return $resource('/classrooms/:id', {
	  id: '@id'
  },
  {
    search: {
			method: 'GET',
			url: '/classrooms/search',
      isArray: true
		},
		subjects: {
			method: 'GET',
			url: '/classrooms/:id/subjects',
      isArray: true
		},
		add_subject: {
			method: 'PUT',
			url: '/classrooms/:id/add_subject'
		},
		remove_subject: {
			method: 'PUT',
			url: '/classrooms/:id/remove_subject'
		},
		set_subjects: {
			method: 'POST',
			url: '/classrooms/:id/set_subjects'
		}
  });
}]);
