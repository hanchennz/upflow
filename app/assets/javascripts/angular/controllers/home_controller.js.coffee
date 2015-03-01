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

  $scope.repeatByOptions = [
    { name: '1 days', value: 1 },
    { name: '2 days', value: 2 },
    { name: '3 days', value: 3 },
    { name: '4 days', value: 4 },
    { name: '5 days', value: 5 },
    { name: '7 days', value: 7 },
    { name: '10 days', value: 10 },
    { name: '14 days', value: 14 },
    { name: '20 days', value: 20 },
    { name: '30 days', value: 30 },
    { name: '60 days', value: 60 }
  ]

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
