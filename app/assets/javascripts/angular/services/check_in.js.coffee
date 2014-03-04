@upflow.factory 'CheckIn', ($resource) ->
  service = $resource(
    '/api/check_ins/:id.json',
    {
      id: '@id',
      task_id: '@task_id',
      user_id: '@user_id'
    },
    update: {
      method: 'PUT'
    },
    save: {
      method: 'POST',
      url: '/api/tasks/:task_id/check_ins.json'
    },
    index: {
      method: 'GET',
      isArray: true,
      url: '/api/tasks/:task_id/check_ins.json'
    },
    user_check_ins: {
      method: 'GET',
      isArray: true,
      url: '/api/users/:user_id/user_check_ins.json'
    }
  )
