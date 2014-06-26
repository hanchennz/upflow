upflow.config ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true

  $routeProvider
  .when '/',
      controller: 'HomeController'
      templateUrl: '../assets/main.html'
    .otherwise redirectTo: '/'

upflow.run (editableOptions) ->
  editableOptions.theme = 'bs3'
