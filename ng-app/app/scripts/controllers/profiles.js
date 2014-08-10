'use strict';

/**
 * @ngdoc function
 * @name edumatcherApp.controller:ProfilesCtrl
 * @description
 * # ProfilesCtrl
 * Controller of the edumatcherApp
 */
angular.module('edumatcherApp')
  .controller('ProfilesCtrl', function ($scope, Classrooms, Schools, SchoolDistricts, Subjects, GradeLevels, Experts, KnowledgeLinks, Companies, EmploymentLinks) {

    $scope.subjects = [];
    $scope.subject_list = [];
    $scope.grade_levels = [];
    $scope.grade_level_list = [];
    $scope.company = '';
    $scope.page = 1;
    $scope.limit = 10;

    $scope.saveExpert = function(){
      var expert = new Experts($scope.session.expert);
      expert.save(function(expert){
        $scope.setExpert(expert.id);
      });
    };

    $scope.addSubjectToExpert = function(subject){
      $scope.session.expert.addSubject(subject);
    };

    $scope.removeSubjectFromExpert = function(knowledge_link){
      knowledge_link = new KnowledgeLinks(knowledge_link);
      knowledge_link.$delete(function(){
        $scope.session.expert.knowledge_links = $.grep($scope.session.expert.knowledge_links, function(kl){ return kl.id !== knowledge_link.id;});
      });
    };

    $scope.addCompanyToExpert = function(){
      if($scope.session.expert.employment_links.length > 0){
        $scope.removeCompanyFromExpert($scope.session.expert.employment_links[0].company);
      }
      $scope.session.expert.addCompany($scope.session.expert.company);
    };

    $scope.removeCompanyFromExpert = function(company){
      $scope.session.expert.removeCompany(company);
    };

    function init(){
      $scope.subject_list = Subjects.query();
      $scope.grade_levels = GradeLevels.query();
    }

    init();

  });
