class Course < ActiveRecord::Base
  belongs_to :creator_user, class_name: 'User', foreign_key: 'creator_user_id'

  validates :title, presence: true

  has_many :course_resgistrations
  has_many :users, through: :course_registrations
end
