@upflow.factory 'Task', [
  "$resource"
  ($resource) ->
  service = $resource(
    '/api/tasks/:id.json',
    {
      id: '@id',
      user_id: '@user_id'
    },
    update: {
      method: 'PUT'
    },
    save: {
      method: 'POST',
      url: '/api/users/:user_id/tasks.json'
    },
    index: {
      method: 'GET',
      isArray: true,
      url: '/api/users/:user_id/tasks.json'
    }
  )
]
