upflow.controller( 'LoginController', ($scope, $http) ->
  $scope.login_user =
    email: null
    password: null

  $scope.login = ->
    $http.post "../users/sign_in.json",
      user:
        email: $scope.login_user.email
        password: $scope.login_user.password

    return

  $scope.logout = ->
    $http
      method: "DELETE"
      url: "../users/sign_out.json"
      data: {}
)
