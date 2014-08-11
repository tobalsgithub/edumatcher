'use strict';

// Factory for interacting with the rails experts api

angular.module('edumatcherApp').factory('Reviews', ['$resource','$http', function($resource,$http) {
  var Reviews =
    $resource('/reviews/:id', {
      id: '@id'
    },
    {
      update: {
        method: 'PUT'
      }
    });


  Reviews.prototype.save = function(cb){
    var _this = this;
    if(_this.id){
      Reviews.update({id: _this.id}, _this, cb);
    }else{
      _this.$save(cb);
    }
  };

  return Reviews;
}]);
