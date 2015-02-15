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

  $scope.repeatByOptions = [ 1, 3, 5, 7, 10, 15, 30 ]

  addNewCheckInForTask = (task) ->
    $scope.newCheckIn =
      task_id: task.id
      task_name: task.name
      created_at: new Date()

  addNewTask = ->
    $scope.newTask =
      created_at: new Date()
      repeat_by: 5
      task_type: 'one_off'
      user_id: $scope.currentUser.id

  updateLastCheckIn = (task_id) ->
    _.findWhere($scope.taskList, {id: task_id}).last_check_in = new Date()

  $scope.deleteCheckIn = (checkIn) ->
    CheckIn.delete { id: checkIn.id }
    , (success) ->
      $scope.checkInList = _.without($scope.checkInList, checkIn)

  $scope.deleteTask = (task) ->
    Task.delete { id: task.id }
    , (success) ->
      $scope.taskList = _.without($scope.taskList, task)

  $scope.saveCheckIn = (newCheckIn) ->
    CheckIn.save
      check_in: newCheckIn
      user_id: $scope.currentUser.id
    , (savedCheckIn) ->
      $scope.checkInList.unshift(savedCheckIn)
      updateLastCheckIn(savedCheckIn.task_id)
      addNewCheckInForTask({ id: newCheckIn.task_id, name: newCheckIn.task_name })

  $scope.saveTask = (task) ->
    Task.save { task: task, user_id: $scope.currentUser.id }
    , (savedTask) ->
      $scope.taskList.push(savedTask)
      addNewTask()

  $scope.toggleDisplay = (task) ->
    $scope.displayedTask = if $scope.displayedTask == task then undefined else task
    oldSearch = $scope.search.task_id
    $scope.search.task_id = 0
    $timeout ->
      $scope.search.task_id = if oldSearch == task.id then undefined else task.id
    , 500
    addNewCheckInForTask(task)
