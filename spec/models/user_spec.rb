require 'spec_helper'

describe User do
  context 'Associations' do
    it { should have_many(:tasks) }
    it { should have_many(:check_ins).through(:tasks).dependent(:destroy) }
  end

  context 'Database' do
    it { should have_db_index(:deleted_at) }
    it { should have_db_index(:email).unique(true) }
    it { should have_db_index(:reset_password_token).unique(true) }
  end

  context 'Mixins' do
    it { should be_paranoid }
    it { should be_versioned }
  end

  context 'Validations' do
    it { should validate_length_of(:email).is_at_most(255) }
  end
end
