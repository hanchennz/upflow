@upflow = angular.module('upflow', [])

#= depend_on_asset 'home.html'

@upflow.config ($routeProvider) ->

  $routeProvider
    .otherwise
      controller: 'HomeController'
      templateUrl: '<%= asset_path("home.html") %>'
