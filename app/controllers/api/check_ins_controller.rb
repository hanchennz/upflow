class Api::CheckInsController < ApplicationController
  before_filter :create_task, only: :create

  def create
    @check_in = CheckIn.new(permitted_params)
    puts 'here'
    if @check_in.save
      render 'show', status: :created
    else
      render_validation_errors @check_in
    end
  end

  def destroy
    @check_in = CheckIn.find(params[:id])
    if @check_in.destroy
      head :no_content
    else
      render_validation_errors @check_in
    end
  end

  def index
    if params[:task_id]
      @check_ins = Task.find(params[:task_id]).check_ins
    elsif params[:user_id]
      @check_ins = User.find(params[:user_id]).check_ins
    end
  end

  def update
    @check_in = CheckIn.find(params[:id])
    if @check_in.update_attributes(permitted_params)
      head :no_content
    else
      render_validation_errors @task
    end
  end

  private

  def permitted_params
    params.require(:check_in).permit(
      :note,
      :task_id
    )
  end

  def create_task
    if params[:check_in][:task_id].nil?
      @new_task = Task.create(
        description: 'Automatically generated task.',
        name: params[:check_in][:task_name],
        repeat_by: params[:check_in][:repeat_by],
        user_id: params[:user_id],
        task_type: 'one_off'
      )
      puts 'create_task'
      params[:check_in][:task_id] = @new_task.id
    end
  end
end