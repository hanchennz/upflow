class Api::TasksController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      render 'show', status: :created
    else
      render_validation_errors @task
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      head :no_content
    else
      render_validation_errors @task
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(permitted_params)
      head :no_content
    else
      render_validation_errors @task
    end
  end

  private

  def permitted_params
    params.require(:task).permit(
      :border_color,
      :color,
      :description,
      :due_at,
      :id,
      :name,
      :type
    )
  end
end
