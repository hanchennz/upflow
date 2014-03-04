class User < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  # Associations
  has_many :check_ins, through: :tasks, dependent: :destroy
  has_many :tasks, dependent: :destroy
end
