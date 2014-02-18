class CheckIn < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  # Associations
  belongs_to :task, inverse_of: :check_ins
  belongs_to :user, inverse_of: :check_ins

  # Validations
  validates :note, presence: true
end
