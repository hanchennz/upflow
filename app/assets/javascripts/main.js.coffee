@upflow = angular.module('upflow', [
  'ng-rails-csrf',
  'ngResource',
  'ngRoute',
  'ui.bootstrap',
  'xeditable'
])

@upflow.config ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true

  $routeProvider
    .when '/',
      controller: 'HomeController'
      templateUrl: '../assets/home.html'
    .otherwise redirectTo: '/'

@upflow.run (editableOptions) ->
  editableOptions.theme = 'bs3'
