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
  validates :description, length: { maximum: 2000 }
  validates :name, length: 1..50
  validates :repeat_by, presence: true
  validates :task_type, presence: true

  def update_colors
    if self.repeat_by.nil?
      self.repeat_by = 5
    end

    if check_ins.last.nil?
      last_check_in = self.repeat_by.months.ago
    else
      last_check_in = check_ins.last.created_at
    end

    if task_type.one_off?
      next_due_date = last_check_in + self.repeat_by.days
      if completed_at?
        update_attributes(color: 'blue', rank: 4)
      elsif next_due_date < DateTime.now
        update_attributes(color: 'red', rank: 0)
      elsif last_check_in + 12.hours > DateTime.now
        update_attributes(color: 'green', rank: 3)
      elsif next_due_date <= 1.day.from_now
        update_attributes(color: 'orange', rank: 1)
      elsif next_due_date <= 2.days.from_now
        update_attributes(color: 'yellow', rank: 2)
      else
        update_attributes(color: 'green', rank: 3)
      end
    end
  end
end
