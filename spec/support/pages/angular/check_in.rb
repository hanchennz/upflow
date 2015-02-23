require_relative '../base'

module Pages
  module Angular
    class CheckIn < Base
      def initialize(check_in)
        @check_in = check_in
        @selector = "#check-ins #check-in-#{@check_in.id}"
      end

      def cancel_note_edit
        check_in_item.find('.editable-buttons .glyphicon-remove').trigger('click')
      end

      def delete_check_in
        check_in_item.find('.glyphicon-trash').trigger('click')
      end

      def edit_check_in
        check_in_item.find('.glyphicon-pencil').trigger('click')
      end

      def has_created_date?(time)
        date = time.strftime('%m/%d/%Y')
        check_in_item.has_content?("Completed on: #{date}")
      end

      def has_note?(note)
        check_in_item.has_css?('.note', text: note)
      end

      def has_task_name?(name)
        check_in_item.has_css?('h4', text: name)
      end

      def note=(note)
        check_in_item.find('textarea.editable-input').set(note)
      end

      def save_note
        check_in_item.find('.editable-buttons .glyphicon-ok').trigger('click')
      end

      private

      def check_in_item
        find(@selector)
      end
    end
  end
end
