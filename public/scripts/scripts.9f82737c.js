"use strict";angular.module("edumatcherApp",["ngAnimate","ngCookies","ngResource","ngSanitize","ngTouch","ui.router","Devise","google-maps","mgcrea.ngStrap"]).config(["$stateProvider","$urlRouterProvider",function(a,b){b.otherwise("/"),a.state("home",{url:"/",templateUrl:"views/index.html"}).state("login",{url:"/login",templateUrl:"views/users/login.html",controller:"UsersCtrl"}).state("classrooms",{url:"/classrooms",templateUrl:"views/classrooms/classrooms.html",controller:"ClassroomsCtrl"}).state("main",{url:"/main",templateUrl:"views/main.html"}).state("about",{url:"/about",templateUrl:"views/about.html"})}]),angular.module("edumatcherApp").controller("MainCtrl",["$scope","$http",function(a,b){a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"],a.proxyTest=function(){b.get("/welcome/proxy_test").success(function(a){console.log(a)})}}]),angular.module("edumatcherApp").controller("AboutCtrl",["$scope",function(a){a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}]),angular.module("edumatcherApp").controller("UsersCtrl",["$scope","$http","Auth",function(a,b,c){a.credentials={email:null,password:null},a.$on("devise:unauthorized",function(d,e,f){console.log("devise:unauthorized"),c.login(a.credentials).then(function(){return console.log("login"),b(e.config)}).then(function(a){console.log("success"),f.resolve(a)},function(a){console.log("error"),f.reject(a)})}),a.login=function(){c.login(a.credentials).then(function(a){console.log(a)},function(a){console.log("err"+a)})},a.logout=function(){c.logout()}}]),angular.module("edumatcherApp").controller("ClassroomsCtrl",["$scope","$http","Classrooms","Subjects",function(a,b,c,d){function e(){a.classrooms=c.search(),a.subjects=d.query()}a.subjects=[],a.classrooms=[],a.subject_list=[],e(),a.$watch("subject_list",function(b,d){b!==d&&(a.classrooms=c.search({"subject_list[]":a.subject_list}))}),a.map={center:{latitude:39.95,longitude:-75.17},zoom:12},a.find=function(){var c={subject_list:a.subject_list,limit:a.limit,page:a.page};b.post("/classrooms/search",c).success(function(b){a.classrooms=b})},a.grade_level_list=[],a.grade_levels=[{name:"Elementary",id:1},{name:"Middle School",id:2},{name:"High School",id:3}],a.within_distances=[{id:1,distance:25,name:"25 miles"},{id:2,distance:50,name:"50 miles"},{id:3,distance:100,name:"100 miles"},{id:999,distance:"9999999",name:"Anywhere"}]}]),angular.module("edumatcherApp").factory("Classrooms",["$resource",function(a){return a("/classrooms/:id",{id:"@id"},{search:{method:"GET",url:"/classrooms/search",isArray:!0},subjects:{method:"GET",url:"/classrooms/:id/subjects",isArray:!0},add_subject:{method:"PUT",url:"/classrooms/:id/add_subject"},remove_subject:{method:"PUT",url:"/classrooms/:id/remove_subject"},set_subjects:{method:"POST",url:"/classrooms/:id/set_subjects"}})}]),angular.module("edumatcherApp").factory("Subjects",["$resource",function(a){return a("/subjects/:id",{id:"@id"})}]);