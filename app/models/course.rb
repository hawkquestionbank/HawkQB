class Course < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_user_id'
  has_many :micro_credential_maps

  validates_presence_of :title, :message => "can't be empty"
  validates :token, :uniqueness=> {:allow_blank => true, :case_sensitive => true}

  has_many :course_registrations
  has_many :users, through: :course_registrations
  has_many :micro_credentials, through: :micro_credential_maps
  has_many :questions

  def closed_to_attempts
    # return true if the current course is closed to new attempts from student (students can no longer
    # submit their answers to the system).
    # otherwise return false
    if self.close_to_attempts.nil?
      false
    else
      DateTime.now > self.close_to_attempts
    end
  end

  def can_see_correct_answers?
    # Determine whether to display
    # if this course is an **exam** (only), compare current time and can_view_answers_after and close_to_attempts, which ever is later
    # if this course is **not** an exam, can_view_answers_after is not empty, compare current time and can_view_answers_after
    # otherwise, by default, students **cannot** see correct answers
    if self.is_an_exam
      DateTime.now > self.can_view_answers_after and DateTime.now > self.can_view_answers_after
    elsif not self.can_view_answers_after.nil?
      DateTime.now > self.can_view_answers_after
    else
      false
    end
  end
end
