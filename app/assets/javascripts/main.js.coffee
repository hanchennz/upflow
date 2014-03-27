#= depend_on_asset 'home.html'

@upflow = angular.module('upflow', [
  'ng-rails-csrf',
  'ngAnimate',
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
