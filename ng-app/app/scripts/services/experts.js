'use strict';

// Factory for interacting with the rails experts api

angular.module('edumatcherApp').factory('Experts', ['$resource','$http', 'KnowledgeLinks','EmploymentLinks', function($resource,$http, KnowledgeLinks, EmploymentLinks) {
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
      },
      reviews: {
        method: 'GET',
        url: '/experts/:id/reviews',
        isArray: true
      }
    });

  Experts.prototype.addSubject = function(subject, cb){
    var _this = this;
    if (!_this.id){
      return; // can't add a subject if this isn't saved yet
    }
    var knowledge_link = new KnowledgeLinks({
      subject_id: subject.id,
      knowledgeable_id: _this.id,
      knowledgeable_type: 'Expert'
    });
    knowledge_link.save(function(kl){
      _this.knowledge_links.push(kl);
      if(cb !== undefined) {
        cb();
      }
    });
  };

  Experts.prototype.addCompany = function(company, cb){
    var _this = this;
    if (!_this.id){
      return; // can't add a subject if this isn't saved yet
    }
    var employment_link = new EmploymentLinks({
      company_id: company.id,
      expert_id: _this.id,
    });
    employment_link.save(function(kl){
      _this.employment_links.push(kl);
      if(cb !== undefined) {
        cb();
      }
    });
  };

  Experts.prototype.removeCompany = function(company, cb){
    var _this = this;
    var employment_link = $.grep(_this.employment_links, function(el){ return el.company.id === company.id;})[0];
    employment_link = new EmploymentLinks(employment_link);
    employment_link.$delete(function(employment_link){
      _this.employment_links = $.grep(_this.employment_links, function(el){ return el.id !== employment_link.id;});
      if(cb !==undefined){
        cb();
      }
    });
  };

  Experts.prototype.save = function(cb){
    var _this = this;
    var subject_list = _this.subjects;
    _this.companies = [];
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
