class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def render_error(message, status)
    render json: { error: message }, status: status
  end

  def render_validation_errors(model)
    render_error model.errors.full_messages, :unprocessable_entity
  end
end
