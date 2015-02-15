class Api::TasksController < ApplicationController
  def create
    @task = Task.new(permitted_params)
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

  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks
  end

  def show
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(permitted_params)
      @task.update_colors
      render 'show', status: :ok
    else
      render_validation_errors @task
    end
  end

  private

  def permitted_params
    params.require(:task).permit(
      :completed_at,
      :description,
      :due_at,
      :id,
      :name,
      :repeat_by,
      :task_type,
      :user_id
    )
  end
end
