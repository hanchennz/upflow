class Api::UsersController < ApplicationController
  def current
    @user = current_user
    render 'show'
  end
end
