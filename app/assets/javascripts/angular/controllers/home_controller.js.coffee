@upflow.controller 'HomeController', ($scope, Session, Task) ->

  Session.getUser (user) ->
    $scope.currentUser = user
    $scope.tasksList = Task.index(user_id: user.id)

  $scope.new_task_form = ->
    $scope.newTasksList ?= []
    $scope.newTasksList.push({
      task_type: 'one_off'
      user_id: $scope.currentUser.id
    })

  $scope.save_task = (task) ->
    Task.save { task: task, user_id: $scope.currentUser.id }
    , (savedTask) ->
      $scope.tasksList.push(savedTask)
      $scope.newTasksList = _.without($scope.newTasksList, task)
    , (error) ->
      console.log('Error in saving task')
      console.log(error)
