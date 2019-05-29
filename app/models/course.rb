class Course < ActiveRecord::Base
  belongs_to :creator_user, class_name: 'User', foreign_key: 'creator_user_id'
  has_many :course_registrations
  has_many :users, through: :course_registrations
end
