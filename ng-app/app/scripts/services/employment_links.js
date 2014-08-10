'use strict';

// Factory for interacting with the rails employment_links api

angular.module('edumatcherApp').factory('EmploymentLinks', ['$resource', '$http', function($resource, $http) {
  var EmploymentLinks =
    $resource('/employment_links/:id', {
      id: '@id'
    },
    {
      update: {
        method: 'PUT'
      }
    });

  EmploymentLinks.prototype.save = function(cb){
    var _this = this;
    if(_this.id){
      EmploymentLinks.update({id: _this.id}, _this, cb);
    }else{
      _this.$save(cb);
    }
  };

  return EmploymentLinks;
}]);
