require_relative '../base'

module Pages
  module Angular
    class Task < Base
      def initialize(task)
        @task = task
        @selector = "#tasks #task-#{@task.id}"
      end

      def cancel_description_edit
        task_item.find('.editable-buttons .glyphicon-remove').trigger('click')
      end

      def complete_task
        task_item.find('.glyphicon-ok').trigger('click')
      end

      def delete_task
        task_item.find('.glyphicon-trash').trigger('click')
      end

      def description=(description)
        task_item.find('textarea.editable-input').set(description)
      end

      def update_repeat_by(repeat_by)
        click_chosen_result(repeat_by, "#task-#{@task.id}")
      end

      def edit_task
        task_item.find('.glyphicon-pencil').trigger('click')
      end

      def restart_task
        task_item.find('.glyphicon-repeat').trigger('click')
      end

      def save_description
        task_item.find('.editable-buttons .glyphicon-ok').trigger('click')
      end

      def toggle
        task_item.trigger('click')
      end

      def has_completed_date?(time)
        date = time.strftime('%m/%d/%Y')
        task_item.has_content?("Completed on: #{date}")
      end

      def has_due_date?(time)
        date = time.strftime('%m/%d/%Y')
        task_item.has_content?("Next Due Date: #{date}")
      end

      def has_description?(description)
        task_item.has_css?('.task-description span', text: description)
      end

      def has_color?(color)
        task_item.has_css?(".task.#{color}")
      end

      def has_repeat_by?
        text = "#{@task.repeat_by} days"
        task_item.has_content?('Remind me every:')
        task_item.has_css?('.chosen-single', text: text)
      end

      private

      def task_item
        find(@selector)
      end
    end
  end
end
