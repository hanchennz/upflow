@upflow = angular.module('upflow', [
  'ng-rails-csrf',
  'ngAnimate',
  'ngResource',
  'ngRoute',
  'ui.bootstrap'
])

@upflow.config ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true

  $routeProvider
    .when '/',
      controller: 'HomeController'
      templateUrl: '../assets/home.html'
    .otherwise redirectTo: '/'
