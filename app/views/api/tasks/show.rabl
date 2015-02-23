object @task
attributes :color, :created_at, :description, :due_at, :id, :name, :rank, :repeat_by, :type, :updated_at
node :completed_at do |task|
  task.completed_at.strftime('%m/%d/%Y') if task.completed_at
end
node :last_check_in do |task|
  task.last_check_in.strftime('%m/%d/%Y') if task.last_check_in
end
node :next_due_date do |task|
  task.next_due_date.strftime('%m/%d/%Y')
end
