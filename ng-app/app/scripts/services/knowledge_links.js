'use strict';

// Factory for interacting with the rails knowledge_links api

angular.module('edumatcherApp').factory('KnowledgeLinks', ['$resource', '$http', function($resource, $http) {
  var KnowledgeLinks =
    $resource('/knowledge_links/:id', {
      id: '@id'
    },
    {
      update: {
        method: 'PUT'
      }
    });

  KnowledgeLinks.prototype.save = function(cb){
    var _this = this;
    if(_this.id){
      KnowledgeLinks.update({id: _this.id}, _this, cb);
    }else{
      _this.$save(cb);
    }
  };

  return KnowledgeLinks;
}]);
