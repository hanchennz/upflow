@upflow = angular.module('upflow', [
  'ngRoute',
  'ui.bootstrap'
])

@upflow.config ($routeProvider) ->
  $routeProvider
    .otherwise
      controller: 'HomeController'
      templateUrl: '../assets/home.html'
