class CheckIn < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  # Associations
  belongs_to :task, inverse_of: :check_ins
  has_one :user, through: :task

  # Validations
  validates :note, length: 1..2000
end
