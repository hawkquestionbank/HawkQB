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
  has_many :attempts

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

  def open_closed_questions_counts
    # find the #s of attempts of the current user on the question in all the registered courses
    # for each questions,
    # 1) when max_attempts is a integer: the number of attempts equals to or higher than max_attempts  => closed
    # 2) when closed_to_attempts is not nil and this time is already passed => closed
    # 3) otherwise => open
    open_closed_questions_counter = {}
    self.courses.each do |course|
      open_closed_questions_counter[course.id] = {}
      open_closed_questions_counter[course.id][:open] = 0
      open_closed_questions_counter[course.id][:closed] = 0
      attempts = Attempt.where(:user_id=>self.id).joins(:question).where("questions.course_id=?", course.id ).order("id desc")
      course.questions.each do |question|
        if not course.close_to_attempts.nil? and DateTime.now > course.close_to_attempts
          open_closed_questions_counter[course.id][:closed] += 1
        elsif not course.max_attempts.nil?
          attempts.where("question_id=?", question.id).size >= course.max_attempts
          open_closed_questions_counter[course.id][:closed] += 1
        else
          open_closed_questions_counter[course.id][:open] += 1
        end
      end
    end
    open_closed_questions_counter
  end

  def can_see_correct_answer question, can_view_answers_after
    # return true if one of the conditions is true
    # 1) if can_view_answers_after is not nil, current time is later than the can_view_answers_after time
    #  (mostly when a course is used for an exam)
    # 2) if can_view_answers_after is nil, when finished_question returns true
  end

  def question_taking_record course
    # produce a hash of the current user's question taking history on the given course:
    # Format:
    # {question_id => {:score => most recent score, :num_attempts => total attempts on this questions}}
    # Sample:
    # {48=>{:score=>100, :num_attempts=>1}, 46=>{:score=>0, :num_attempts=>5}}
    attempts = Attempt.where(:user_id=>self.id).joins(:question).where("questions.course_id=?", course.id ).order("id desc")
    personal_question_taking_record = {}
    course.questions.each do |question|
      attempts_on_this_question = attempts.where("question_id=?", question.id)
      if attempts_on_this_question.nil? or attempts_on_this_question.empty?
      else
        latest_attempt = attempts_on_this_question.first
        personal_question_taking_record[question.id] = {}
        personal_question_taking_record[question.id][:score] = latest_attempt.score
        personal_question_taking_record[question.id][:num_attempts] = attempts_on_this_question.size
      end
    end

    personal_question_taking_record
  end
end