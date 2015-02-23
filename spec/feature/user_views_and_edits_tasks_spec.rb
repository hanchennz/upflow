require 'spec_helper'

feature 'User views tasks on main page', js: true do
  scenario 'can create new tasks' do
    user = create(:user)
    new_task = build(:task)

    login_as user
    main_page.go

    main_page.new_task = new_task
    main_page.create_new_task

    expect(main_page).to have_task_count(1)
    expect(main_page).to have_content(new_task.name)
  end

  context 'with existing task' do
    background do
      @user = create(:user)
      @task = create(:task, user: @user)

      login_as @user
      main_page.go
      task_item.toggle
    end

    scenario 'can see task content' do
      expect(task_item).to have_description(@task.description)
      expect(task_item).to have_repeat_by
      expect(task_item).to have_color('green')
    end

    scenario 'can edit task description and restore original description on cancel' do
      new_description = 'New Description for Task'

      task_item.edit_task
      task_item.description = new_description
      task_item.save_description
      expect(task_item).to have_description(new_description)

      main_page.go
      task_item.toggle
      task_item.edit_task
      task_item.description = 'Hello'
      task_item.cancel_description_edit
      expect(task_item).to have_description(new_description)

      main_page.go
      task_item.toggle
      expect(task_item).to have_description(new_description)
    end

    scenario 'can edit task repeat_by' do
      task_item.update_repeat_by('3 days')

      main_page.go
      task_item.toggle
      date = 3.days.from_now
      expect(task_item).to have_due_date(date)
    end

    scenario 'can delete task' do
      task_item.delete_task
      main_page.go

      expect(main_page).to have_no_task(@task)
    end

    scenario 'can complete and restart a task' do
      task_item.complete_task
      expect(task_item).to have_color('blue')
      expect(task_item).to have_completed_date(@task.reload.completed_at)

      main_page.go
      expect(task_item).to have_color('blue')

      task_item.toggle
      task_item.restart_task
      expect(task_item).to have_color('green')
      expect(task_item).to have_due_date(@task.next_due_date)

      main_page.go
      expect(task_item).to have_color('green')
    end
  end

  def main_page
    @main_page || Pages::Angular::Main.new
  end

  def task_item
    @task_item || Pages::Angular::Task.new(@task)
  end
end
