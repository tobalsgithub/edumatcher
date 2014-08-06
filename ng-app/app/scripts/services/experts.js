'use strict';

// Factory for interacting with the rails experts api

angular.module('edumatcherApp').factory('Experts', ['$resource','$http', function($resource,$http) {
  var Experts =
    $resource('/experts/:id', {
      id: '@id'
    },
    {
      update: {
        method: 'PUT'
      },
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
      },
      set_companies: {
        method: 'POST',
        url: '/experts/:id/set_companies'
      }
    });

  Experts.prototype.save = function(cb){
    var _this = this;
    var subject_list = _this.subjects;
    if(_this.id){
      Experts.update({id: _this.id}, _this, function(){
        _this.set_subjects(cb);
      });
    }else{
      _this.$save(function(){
        _this.subjects = subject_list;
        _this.set_subjects(cb);
      });
    }
  };

  Experts.prototype.set_subjects = function(cb){
    var subject_list = this.subjects.map(function(subject){
      return subject.id;
    });
    $http.post('/experts/' + this.id + '/set_subjects', {subject_list: subject_list}).success(cb);
  };

  Experts.prototype.set_companies = function(cb){
    var company_list = this.companies.map(function(company){
      return company.id;
    });
    $http.post('/experts/' + this.id + '/set_companies', {company_list: company_list}).success(cb);
  };

  return Experts;
}]);
