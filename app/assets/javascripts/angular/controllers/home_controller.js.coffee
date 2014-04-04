upflow.controller 'HomeController', ($scope, CheckIn, Session, Task) ->

  Session.getUser (user) ->
    $scope.currentUser = user
    $scope.taskList = Task.index(user_id: user.id)
    $scope.checkInList = CheckIn.queryUser(user_id: user.id)
    $scope.search = {}
    addNewTask()

  $scope.repeat_by_options = [ 1, 3, 5, 7, 10, 15, 30 ]

  $scope.toggleDisplay = (task) ->
    $scope.displayedTask = if $scope.displayedTask == task then undefined else task
    $scope.search.task_id = if $scope.search.task_id == task.id then undefined else task.id
    $scope.newCheckInForTask(task)

  $scope.displayed = (task) -> $scope.displayedTask == task if $scope.displayedTask
  $scope.toggleEditMode = (object) ->
    object.editMode = if object.editMode? then !object.editMode else true
  $scope.toggleXEditMode = (form) -> form.$show()
  $scope.editEnabled = (form) -> form.$visible
  addNewTask = ->
    $scope.newTask = {
      created_at: new Date(),
      repeat_by: 5,
      task_type: 'one_off',
      user_id: $scope.currentUser.id }
  start = new Date().setHours(0,0,0,0)
  $scope.done = (task) -> Date.parse(task.last_check_in) > start

  $scope.saveTask = (task) ->
    Task.save { task: task, user_id: $scope.currentUser.id }
    , (savedTask) ->
      $scope.taskList.push(savedTask)
      addNewTask()
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

  $scope.updateTaskDescription = (description, task) ->
    unless description?
      return 'Task description cannot be blank.'
    Task.update { task: {description: description}, id: task.id }
    , (success) ->
      task.oldDescription = task.description
      console.log('The task description was successfully updated')
    , (error) ->
      task.description = task.oldDescription
      console.log('There was an error in updating the task description')

  $scope.updateTaskName = (name, task) ->
    unless name?
      return 'Task name cannot be blank.'
    Task.update { task: {name: name}, id: task.id }
    , (success) ->
      task.oldName = task.name
      console.log('The task name was successfully updated')
    , (error) ->
      task.name = task.oldName
      console.log('There was an error in updating the task name')

  $scope.updateTaskRepeat = (task, option) ->
    Task.update { task: { repeat_by: option }, id: task.id }
    , (success) ->
      task.repeat_by = option
    , (error) ->
      console.log("error in updating task repeat")

  $scope.newCheckInForTask = (task) ->
    $scope.newCheckInList ?= []
    unless _.findWhere($scope.newCheckInList, {task_id: task.id})
      $scope.newCheckInList.push({
        task_id: task.id
        task_name: task.name
        created_at: new Date()
      })

  $scope.updateLastCheckIn = (task_id) ->
    _.findWhere($scope.taskList, {id: task_id}).last_check_in = new Date()

  $scope.saveCheckIn = (newCheckIn) ->
    CheckIn.save
      check_in: newCheckIn
      user_id: $scope.currentUser.id
    , (savedCheckIn) ->
      $scope.checkInList.push(savedCheckIn)
      $scope.updateLastCheckIn(savedCheckIn.task_id)
      $scope.newCheckInList = _.without($scope.newCheckInList, newCheckIn)
      $scope.newCheckInForTask({ id: newCheckIn.task_id, name: newCheckIn.task_name })
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
