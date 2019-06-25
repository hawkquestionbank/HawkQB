class Course < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_user_id'
  has_many :micro_credential_maps

  validates_presence_of :title, :message => "can't be empty"
  validates :token, :uniqueness=> {:allow_blank => true, :case_sensitive => true}

  has_many :course_registrations
  has_many :users, through: :course_registrations
  has_many :micro_credentials, through: :micro_credential_maps

end
