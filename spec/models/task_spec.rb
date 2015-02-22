require 'spec_helper'

describe Task do
  context 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:check_ins).dependent(:destroy) }
  end

  context 'Database' do
    it { should have_db_index(:user_id) }
    it { should have_db_index(:deleted_at) }
  end

  context 'Mixins' do
    it { should be_paranoid }
    it { should be_versioned }
    it do
      should enumerize(:color)
        .in(:blue, :green, :orange, :red, :yellow)
        .with_default(:green)
    end
    it { should enumerize(:task_type).in(:one_off, :repeating) }
  end

  context 'Validations' do
    it { should validate_length_of(:description).is_at_most(2000) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(50) }

    it { should validate_presence_of(:color) }
    it { should validate_presence_of(:repeat_by) }
    it { should validate_presence_of(:task_type) }
  end

  context 'Methods' do
    before do
      @task = create(:task, repeat_by: 10)
    end

    describe '#last_check_in' do
      it 'returns return nil if task has no check_ins' do
        expect(@task.last_check_in).to be_nil
      end

      it 'returns the created_at of the last check in' do
        create_list(:check_in, 2, task: @task)
        latest_check_in = create(:check_in, task: @task)

        expect(@task.last_check_in).to eq(latest_check_in.created_at)
      end
    end

    describe '#next_due_date' do
      it 'returns the date that is repeat_by days after the latest check in' do
        check_in = create(:check_in, task: @task)
        expect(@task.next_due_date).to eq(check_in.created_at + 10.days)
      end

      it 'returns the date that is repeat_by days after created_at if no check_ins exist' do
        expect(@task.next_due_date).to eq(@task.created_at + 10.days)
      end
    end

    describe '#update_colors' do
      it 'updates the color based on the next_due_date' do
        colors = [
          { color: 'green', rank: 3, repeat_by: 4 },
          { color: 'yellow', rank: 2, repeat_by: 2 },
          { color: 'orange', rank: 1, repeat_by: 1 },
          { color: 'red', rank: 0, repeat_by: 0 }
        ]

        for color in colors
          @task.update_attributes(repeat_by: color[:repeat_by])
          @task.reload
          expect(@task.color).to eq(color[:color])
          expect(@task.rank).to eq(color[:rank])
        end
      end

      it 'updates the color when the task is incomplete' do
        @task.update_attributes(completed_at: Time.now)
        @task.reload
        expect(@task.color).to eq('blue')
        expect(@task.rank).to eq(4)
      end
    end
  end
end
