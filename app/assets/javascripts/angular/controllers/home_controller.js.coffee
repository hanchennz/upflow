upflow.controller 'HomeController', ($scope, $timeout, CheckIn, Session, Task) ->

  $scope.loading = true

  Session.getUser (user) ->
    $scope.currentUser = user
    $scope.taskList = Task.index
      user_id: user.id
      , (success) ->
        $scope.checkInList = CheckIn.queryUser
          user_id: user.id
          , (success) ->
            $scope.loading = false
    $scope.search = {}
    addNewTask()

  $scope.repeat_by_options = [ 1, 3, 5, 7, 10, 15, 30 ]

  $scope.toggleDisplay = (task) ->
    $scope.displayedTask = if $scope.displayedTask == task then undefined else task
    oldSearch = $scope.search.task_id
    $scope.search.task_id = 0
    $timeout(
      -> $scope.search.task_id = if oldSearch == task.id then undefined else task.id,
      500
    )
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

  $scope.deleteTask = (task) ->
    Task.delete { id: task.id }
    , (success) ->
      $scope.taskList = _.without($scope.taskList, task)

  $scope.updateTaskDescription = (description, task) ->
    Task.update { task: {description: description}, id: task.id }
    , (success) ->
      task.oldDescription = task.description
    , (error) ->
      task.description = task.oldDescription

  $scope.updateTaskName = (name, task) ->
    unless name?
      return 'Task name cannot be blank.'
    Task.update { task: {name: name}, id: task.id }
    , (success) ->
      task.oldName = task.name
    , (error) ->
      task.name = task.oldName

  $scope.updateTaskRepeat = (task, option) ->
    Task.update { task: { repeat_by: option }, id: task.id }
    , (success) ->
      task.repeat_by = option

  $scope.newCheckInForTask = (task) ->
    $scope.newCheckIn = {
      task_id: task.id
      task_name: task.name
      created_at: new Date()
    }

  $scope.updateLastCheckIn = (task_id) ->
    _.findWhere($scope.taskList, {id: task_id}).last_check_in = new Date()

  $scope.saveCheckIn = (newCheckIn) ->
    CheckIn.save
      check_in: newCheckIn
      user_id: $scope.currentUser.id
    , (savedCheckIn) ->
      $scope.checkInList.unshift(savedCheckIn)
      $scope.updateLastCheckIn(savedCheckIn.task_id)
      $scope.newCheckInForTask({ id: newCheckIn.task_id, name: newCheckIn.task_name })

  $scope.deleteCheckIn = (checkIn) ->
    CheckIn.delete { id: checkIn.id }
    , (success) ->
      $scope.checkInList = _.without($scope.checkInList, checkIn)

  $scope.updateCheckIn = (note, checkIn) ->
    if note == undefined
      return 'Saved check-ins cannot be blank.'
    CheckIn.update { check_in: { note: note }, id: checkIn.id }
    , (success) ->
      checkIn.oldNote = checkIn.note
    , (error) ->
      checkIn.note = checkIn.oldNote

  $scope.convertToDate = (date) ->
    new Date(date)
