object @check_in
attributes :created_at, :id, :note, :task_id, :updated_at
node :task_name do |check_in|
  if check_in.task
    check_in.task.name
  end
end
