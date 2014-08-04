'use strict';

// Factory for interacting with the rails classrooms api

angular.module('edumatcherApp').factory('Classrooms', ['$resource', '$http', function($resource, $http) {
	var Classrooms =
		$resource('/classrooms/:id', {
			id: '@id'
		},
		{
			update: {
				method: 'PUT'
			},
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
			}// ,
			// set_subjects: {
			// 	method: 'POST',
			// 	url: '/classrooms/:id/set_subjects'
			// }
		});

	Classrooms.prototype.save = function(cb){
		var _this = this;
		if(_this.id){
			Classrooms.update({id: _this.id}, _this, function(){
				_this.set_subjects(cb);
			});
			//this.update(this.set_subjects(cb));
		}else{
			_this.$save(function(){
				_this.set_subjects(cb);
			});
		}
	};

	Classrooms.prototype.set_subjects = function(cb){
		var subject_list = this.subjects.map(function(subject){
			return subject.id;
		});
		$http.post('/classrooms/' + this.id + '/set_subjects', {subject_list: subject_list}).success(cb);
	};

	return Classrooms;
}]);
