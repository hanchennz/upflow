@upflow.controller 'HomeController', ($scope, Session, Task) ->

  Session.getUser (user) ->
    $scope.currentUser = user
    $scope.taskList = Task.index(user_id: user.id)

  $scope.newTaskForm = ->
    $scope.newTaskList ?= []
    $scope.newTaskList.push({
      task_type: 'one_off'
      user_id: $scope.currentUser.id
    })

  $scope.saveTask = (task) ->
    Task.save { task: task, user_id: $scope.currentUser.id }
    , (savedTask) ->
      $scope.taskList.push(savedTask)
      $scope.newTaskList = _.without($scope.newTaskList, task)
    , (error) ->
      console.log('Error in saving task')
      console.log(error)

  $scope.deleteTask = (task) ->
    Task.delete { id: task.id }
    , (success) ->
      $scope.taskList = _.without($scope.taskList, task)
      console.log('Task was successfully deleted')
    , (error) ->
      console.log('There was an error in delete the task')
