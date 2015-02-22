require 'spec_helper'

describe CheckIn do
  context 'Associations' do
    it { should belong_to(:task) }
    it { should have_one(:user).through(:task) }
  end

  context 'Database' do
    it { should have_db_index(:task_id) }
  end

  context 'Mixins' do
    it { should be_paranoid }
    it { should be_versioned }
  end

  context 'Validations' do
    it { should validate_length_of(:note).is_at_least(1).is_at_most(2000) }
  end
end
