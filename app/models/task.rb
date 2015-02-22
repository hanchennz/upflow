class Task < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid
  has_paper_trail

  after_find :update_colors

  # Associations
  belongs_to :user, inverse_of: :tasks
  has_many :check_ins, dependent: :destroy, inverse_of: :task

  # Mixins
  enumerize :color,
            default: :green,
            in: %i(red orange yellow green blue),
            scope: true,
            predicates: true
  enumerize :task_type, in: %i(one_off repeating), scope: true, predicates: true

  # Validations
  validates :color, presence: true
  validates :description, length: { maximum: 2000 }
  validates :name, length: 1..50
  validates :repeat_by, presence: true
  validates :task_type, presence: true

  def last_check_in
    return nil unless check_ins.any?
    check_ins.last.created_at
  end

  def next_due_date
    if last_check_in.nil?
      created_at + repeat_by.days
    else
      last_check_in + repeat_by.days
    end
  end

  def update_colors
    return false unless task_type.one_off?

    case
    when completed_at?
      update_attributes(color: 'blue', rank: 4)
    when next_due_date < DateTime.now
      update_attributes(color: 'red', rank: 0)
    when next_due_date <= 1.day.from_now
      update_attributes(color: 'orange', rank: 1)
    when next_due_date <= 2.days.from_now
      update_attributes(color: 'yellow', rank: 2)
    else
      update_attributes(color: 'green', rank: 3)
    end
  end
end
