"use strict";angular.module("edumatcherApp",["ngAnimate","ngCookies","ngResource","ngRoute","ngSanitize","ngTouch"]).config(["$routeProvider",function(a){a.when("/",{templateUrl:"views/main.html",controller:"MainCtrl"}).when("/about",{templateUrl:"views/about.html",controller:"AboutCtrl"}).otherwise({redirectTo:"/"})}]),angular.module("edumatcherApp").controller("MainCtrl",["$scope","$http",function(a,b){a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"],a.proxyTest=function(){b.get("/welcome/proxy_test").success(function(a){console.log(a)})}}]),angular.module("edumatcherApp").controller("AboutCtrl",["$scope",function(a){a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}]);