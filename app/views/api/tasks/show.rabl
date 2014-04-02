object @task
attributes :border_color, :color, :created_at, :description, :due_at, :id, :name, :rank, :repeat_by, :type, :updated_at
node :last_check_in do |task|
  if task.last_check_in
    task.last_check_in
  end
end
