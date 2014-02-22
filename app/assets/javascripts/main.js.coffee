@upflow = angular.module('upflow', [
  'ngRoute'
])

@upflow.config ($routeProvider) ->
  $routeProvider
    .otherwise
      controller: 'HomeController'
      templateUrl: '../assets/home.html'
