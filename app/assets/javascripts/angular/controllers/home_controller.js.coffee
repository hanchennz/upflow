@upflow.controller 'HomeController', ($scope, Session) ->
  $scope.logout = ->
    Session.logout()
