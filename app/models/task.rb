class Task < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid
  has_paper_trail

  # Associations
  belongs_to :user, inverse_of: :tasks
  has_many :check_ins, dependent: :destroy, inverse_of: :task

  # Mixins
  enumerize :border_color,
            default: :none,
            in: %i(red orange yellow green blue none),
            scope: true,
            predicates: true
  enumerize :color,
            default: :green,
            in: %i(red orange yellow green blue),
            scope: true,
            predicates: true
  enumerize :task_type, in: %i(one_off repeating), scope: true, predicates: true

  # Validations
  validates :border_color, presence: true
  validates :color, presence: true
  validates :name, presence: true
  validates :task_type, presence: true
end
