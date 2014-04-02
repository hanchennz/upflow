object @task
attributes :border_color, :color, :created_at, :description, :due_at, :id, :name, :rank, :repeat_by, :type, :updated_at
node :last_check_in do |task|
  task.try(:last_check_in)
end
node :next_due_date do |task|
  task.try(:next_due_date)
end
