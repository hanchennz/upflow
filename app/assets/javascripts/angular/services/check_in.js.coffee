upflow.factory 'CheckIn', ($resource) ->
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
    query: {
      method: 'GET',
      isArray: true,
      url: '/api/tasks/:task_id/check_ins.json'
    },
    queryUser: {
      method: 'GET',
      isArray: true,
      url: '/api/users/:user_id/check_ins.json'
    }
  )
