require 'spec_helper'

feature 'User views and edits tasks', js: true do
  background do
    @user = create(:user)
    @task = create(:task, user: @user)
    @check_in = create(:check_in, task: @task)

    login_as(@user, scope: :user)
    main_page.go
  end

  scenario 'can see check in content' do
    expect(check_in_item).to have_note(@check_in.note)
    expect(check_in_item).to have_task_name(@task.name)
  end

  scenario 'can create new check in' do
    new_check_in = build(:check_in)
    task_item.toggle

    main_page.new_check_in = new_check_in
    main_page.create_new_check_in

    expect(main_page).to have_check_in_count(3)
    expect(main_page).to have_content(new_check_in.note)
  end

  scenario 'can edit check_in note' do
    new_note = 'New Note for Task'
    check_in_item.edit_check_in
    check_in_item.note = new_note
    check_in_item.save_note
    expect(check_in_item).to have_note(new_note)

    main_page.go
    check_in_item.edit_check_in
    check_in_item.note = 'Hello'
    check_in_item.cancel_note_edit
    expect(check_in_item).to have_note(new_note)

    main_page.go
    expect(check_in_item).to have_note(new_note)
  end

  scenario 'can delete check in' do
    check_in_item.delete_check_in
    expect(main_page).to have_no_check_in(@check_in)
  end

  def check_in_item
    @check_in_item || Pages::Angular::CheckIn.new(@check_in)
  end

  def main_page
    @main_page || Pages::Angular::Main.new
  end

  def task_item
    @task_item || Pages::Angular::Task.new(@task)
  end
end
