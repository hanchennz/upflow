upflow.config ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true

  $routeProvider
  .when '/',
      controller: 'HomeController'
      templateUrl: '../assets/home.html'
    .otherwise redirectTo: '/'

upflow.run (editableOptions) ->
  editableOptions.theme = 'bs3'
