@upflow.controller 'HomeController', ($scope, Session, Task) ->

  Session.getUser (user) ->
    $scope.currentUser = user
    $scope.tasksList = Task.index(user_id: user.id)
