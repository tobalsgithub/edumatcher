'use strict';

// Factory for interacting with the rails companies api

angular.module('edumatcherApp').factory('Companies', ['$resource', '$http', function($resource, $http) {
  var Companies =
    $resource('/companies/:id', {
      id: '@id'
    },
    {
      update: {
        method: 'PUT'
      },
      // search: {
      //   method: 'GET',
      //   url: '/companies/search',
      //   isArray: true
      // },
    });

  Companies.search = function(searchText, cb){
    return $http.get('/companies/search?search_text='+searchText).then(function(response){
      return cb(response.data);
    });
  };

  Companies.prototype.save = function(cb){
    var _this = this;
    if(_this.id){
      Companies.update({id: _this.id}, _this, cb);
    }else{
      _this.$save(cb);
    }
  };

  return Companies;
}]);
