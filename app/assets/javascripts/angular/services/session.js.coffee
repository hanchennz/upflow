# app.factory 'Session', ($log, $resource, $http) ->
#   service = $resource '/api/users/:action.json', { action: '@action' },
#     current: { method: 'GET', params: { action: 'current'} }

#   session =
#     user: {}

#     authorized: ->
#       !!session.user.id

#     getUser: (success, failure) ->
#       if session.authorized()
#         success(session.user) if angular.isFunction success
#         return session.user
#       else
#         service.current {}
#         , (result) ->
#           session.user = result || {}
#           success(result) if angular.isFunction success
#         , (error) ->
#           session.user = {}
#           failure(error) if angular.isFunction failure

#   session
