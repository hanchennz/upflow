require_relative '../base'

module Pages
  module Angular
    class Main < Base
      def create_new_check_in
        click_on 'Check In'
      end

      def create_new_task
        click_on 'Create Task'
      end

      def has_no_check_in?(check_in)
        has_no_css?("#check-ins #check-in-#{check_in.id}")
      end

      def has_no_task?(task)
        has_no_css?("#tasks #task-#{task.id}")
      end

      def has_task_count?(count)
        has_css?('.task', count: count)
      end

      def has_check_in_count?(count)
        has_css?('.check-in', count: count)
      end

      def new_check_in=(check_in)
        find('#new-check-in-note').set(check_in.note)
      end

      def new_task=(task)
        find('#new-task-name').set(task.name)
        find('#new-task-description').set(task.description)
        click_chosen_result("#{task.repeat_by} days", '#new-task-repeat-by')
      end

      private

      def path
        '/'
      end
    end
  end
end
