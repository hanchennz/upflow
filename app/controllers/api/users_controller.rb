class Api::UsersController < ApplicationController
  def current
    @user = User.find(current_user)
    render 'show'
  end
end
