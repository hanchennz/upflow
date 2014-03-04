class Api::CheckInsController < ApplicationController
  def create
    @check_in = CheckIn.new(permitted_params)
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
    @check_ins = Task.find(params[:task_id]).check_ins
  end

  def update
    @check_in = CheckIn.find(params[:id])
    if @check_in.update_attributes(permitted_params)
      head :no_content
    else
      render_validation_errors @task
    end
  end

  def user_check_ins
    @check_ins = User.find(params[:user_id]).check_ins
  end

  private

  def permitted_params
    params.require(:check_in).permit(
      :note,
      :task_id
    )
  end
end