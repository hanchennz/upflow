@upflow.controller 'HomeController', ($scope, CheckIn, Session, Task) ->

  Session.getUser (user) ->
    $scope.currentUser = user
    $scope.taskList = Task.index(user_id: user.id)
    $scope.checkInList = CheckIn.queryUser(user_id: user.id)

  $scope.toggleDisplay = (task) ->
    task.display ?= false
    task.display = !task.display

  $scope.toggleEditMode = (object) ->
    object.editMode ?= false
    object.editMode = !object.editMode

  $scope.newTaskForm = ->
    $scope.newTaskList ?= []
    $scope.newTaskList.push({
      task_type: 'one_off'
      user_id: $scope.currentUser.id
    })

  $scope.removeUnsavedTask = (task) ->
    $scope.newTaskList = _.without($scope.newTaskList, task)

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

  $scope.updateTask = (task) ->
    Task.update { task: task, id: task.id }
    , (success) ->
      $scope.toggleEditMode(task)
      console.log('The task was successfully updated')
    , (error) ->
      console.log('There was an error in updating the task')

  $scope.newCheckInForTask = (task) ->
    $scope.newCheckInList ?= []
    $scope.newCheckInList.push({
      task_id: task.id
      task_name: task.name
    })

  $scope.removeUnsavedCheckIn = (checkIn) ->
    $scope.newCheckInList = _.without($scope.newCheckInList, checkIn)

  $scope.saveCheckIn = (checkIn) ->
    CheckIn.save { check_in: checkIn, task_id: checkIn.task_id }
    , (savedCheckIn) ->
      $scope.checkInList.push(savedCheckIn)
      $scope.newCheckInList = _.without($scope.newCheckInList, checkIn)
    , (error) ->
      console.log('Error in saving check in')
      console.log(error)

  $scope.deleteCheckIn = (checkIn) ->
    CheckIn.delete { id: checkIn.id }
    , (success) ->
      $scope.checkInList = _.without($scope.checkInList, checkIn)
      console.log('checkIn was successfully deleted')
    , (error) ->
      console.log('There was an error in delete the checkIn')

  $scope.updateCheckIn = (checkIn) ->
    CheckIn.update { check_in: checkIn, id: checkIn.id }
    , (success) ->
      $scope.toggleEditMode(checkIn)
      console.log('The check in was successfully updated')
    , (error) ->
      console.log('There was an error in updating the check in')







