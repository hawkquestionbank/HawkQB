class User < ActiveRecord::Base
  ############################################################################################
  ## PeterGate Roles                                                                        ##
  ## The :user role is added by default and shouldn't be included in this list.             ##
  ## The :root_admin can access any page regardless of access settings. Use with caution!   ##
  ## The multiple option can be set to true if you need users to have multiple roles.       ##
  petergate(roles: [:admin, :instructor, :student], multiple: false)                        ##

  ############################################################################################ 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :own_courses, class_name: 'Course', foreign_key: 'creator_user_id', dependent: :destroy
  has_many :own_micro_credentials, class_name: 'MicroCredential', foreign_key: 'creator_user_id', dependent: :destroy
  has_many :course_registrations
  has_many :courses, through: :course_registrations
  has_many :own_questions, class_name: 'Question', foreign_key: 'creator_user_id', dependent: :destroy
  has_many :own_multiple_choices, class_name: 'MultipleChoice', foreign_key: 'creator_user_id', dependent: :destroy
  has_many :own_multiple_selects, class_name: 'MultipleSelect', foreign_key: 'creator_user_id', dependent: :destroy
  has_many :own_fill_in_the_blanks, class_name: 'FillInTheBlank', foreign_key: 'creator_user_id', dependent: :destroy


  def full_name
    combined_name = (first_name.nil? ? "":first_name) + ' ' + (last_name.nil? ? "":last_name)
    if combined_name.length <= 3
      combined_name = "please update your user name"
    end
    combined_name
  end

  def owns target_object
    self.id == target_object.creator_user_id
  end

  def finished_question question, max_attempts, close_to_attempts
    # find the attempts of the current user on the question
    # return true if one of the conditions is true
    # 1) when max_attempts is a integer: the number of **finished** attempts equals to or higher than max_attempts
    # 2) when close_to_attempts is earlier than current time
  end

  def can_see_correct_answer question, can_view_answers_after
    # return true if one of the conditions is true
    # 1) if can_view_answers_after is not nil, current time is later than the can_view_answers_after time
    #  (mostly when a course is used for an exam)
    # 2) if can_view_answers_after is nil, when finished_question returns true
  end
end