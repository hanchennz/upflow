@upflow.controller 'HomeController', ($scope, CheckIn, Session, Task) ->

  Session.getUser (user) ->
    $scope.currentUser = user
    $scope.taskList = Task.index(user_id: user.id)
    $scope.checkInList = CheckIn.queryUser(user_id: user.id)
    $scope.search = {}

  $scope.newCheckIn = { created_at: new Date() }

  $scope.toggleDisplay = (task) ->
    $scope.displayedTask = if $scope.displayedTask == task then undefined else task
    $scope.search.task_id = if $scope.search.task_id == task.id then undefined else task.id
    $scope.newCheckInForTask(task)

  $scope.displayed = (task) -> $scope.displayedTask == task if $scope.displayedTask
  $scope.toggleEditMode = (object) ->
    object.editMode = if object.editMode? then !object.editMode else true
  $scope.toggleXEditMode = (form) -> form.$show()
  $scope.editEnabled = (form) -> form.$visible

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
      console.log('The task was successfully updated')
    , (error) ->
      console.log('There was an error in updating the task')

  $scope.newCheckInForTask = (task) ->
    $scope.newCheckInList ?= []
    unless _.findWhere($scope.newCheckInList, {task_id: task.id})
      $scope.newCheckInList.push({
        task_id: task.id
        task_name: task.name
        created_at: new Date()
      })

  $scope.saveCheckIn = (newCheckIn) ->
    CheckIn.save
      check_in: newCheckIn
      user_id: $scope.currentUser.id
    , (savedCheckIn) ->
      $scope.checkInList.push(savedCheckIn)
      if newCheckIn.task_id?
        $scope.newCheckInList = _.without($scope.newCheckInList, newCheckIn)
        $scope.newCheckInForTask({ id: newCheckIn.task_id, name: newCheckIn.task_name })
      else $scope.newCheckIn = { created_at: new Date() }
    , (error) ->
      console.log('Error in saving check in')

  $scope.deleteCheckIn = (checkIn) ->
    CheckIn.delete { id: checkIn.id }
    , (success) ->
      $scope.checkInList = _.without($scope.checkInList, checkIn)
    , (error) ->
      console.log('There was an error in delete the checkIn')

  $scope.updateCheckIn = (note, checkIn) ->
    if note == undefined
      return 'Saved check-ins cannot be blank.'
    CheckIn.update { check_in: { note: note }, id: checkIn.id }
    , (success) ->
      checkIn.oldNote = checkIn.note
      console.log('The check in was successfully updated')
    , (error) ->
      checkIn.note = checkIn.oldNote
      console.log('There was an error in updating the check in')
