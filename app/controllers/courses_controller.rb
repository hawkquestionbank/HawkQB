class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :manage_registrations, :add_student_using_email, :drop_student, :clone]
  access all: [:show], instructor: {except: [:index]}, admin: :all, student: [:self_register_using_token]

  # GET /courses
  def index
    # this view should be removed later - we used dashboards instead
    @courses = Course.all
  end

  # GET /courses/1
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    # use the current_user's id as the creator_user_id of the new course
    @course.creator_user_id = current_user.id

    if @course.save

      if @course.is_an_exam and (@course.close_to_attempts.nil? or @course.can_view_answers_after.nil?)
        redirect_to edit_course_path(@course), alert: 'Course was successfully created, but you should specify close time and answers open time.'
      else
        redirect_to redirect_to_dashboard, notice: 'Course was successfully created.'
      end

    else
      render :new
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)

      if @course.is_an_exam and (@course.close_to_attempts.nil? or @course.can_view_answers_after.nil?)
        redirect_to edit_course_path(@course), alert: 'Course was successfully updated, but you should specify close time and answers open time.'
      else
        redirect_to @course, notice: 'Course was successfully updated.'
      end

    else
      render :edit
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to redirect_to_dashboard, notice: 'Course was successfully destroyed.'
  end

  def manage_registrations
  end

  def drop_student
    course_registration = CourseRegistration.find_by(user_id: params[:student_id], course_id: @course.id)
    begin
      course_registration.destroy
      message = 'Student has been removed from this course.'
      redirect_to({controller: "courses", action: "manage_registrations", id: @course.id}, notice: message )
    rescue
      message = 'Something went wrong. Please check whether student is currently in course.'
      redirect_to({controller: "courses", action: "manage_registrations", id: @course.id}, alert: message )
    end
  end

  def add_student_using_email
    respond_to do |format|
      begin
        # check whether the user is valid
        user = User.find_by_email(params["user"]["email"])
        if (user.nil?)
          error_message = 'Email does not exist'
          raise error_message
        end
        # check whether this student is already in the course
        registration = CourseRegistration.where(user_id: user.id, course_id: @course.id)
        if (!registration.empty?)
          error_message = 'Student is already in course'
          raise error_message
        else
          # create a new course registration record
          registration = CourseRegistration.new(user_id: user.id, course_id: @course.id)
          if (registration.save)
            message = 'Student has been added successfully.'
            format.html { redirect_to({controller: "courses", action: "manage_registrations", id: @course.id}, notice: message ) }
          else
            error_message = 'Could not be added to the course due to internal error.'
            raise error_message
          end
        end
      rescue
        format.html { redirect_to({controller: "courses", action: "manage_registrations", id: @course.id}, alert: error_message) }
      end
    end
  end

  def self_register_using_token
    respond_to do |format|
      begin
        # check whether the user is valid
        user = User.find(params["user_id"])
        if (user.nil?)
          error_message = 'Try to login again'
          raise error_message
        end

        # check the length of token
        if params["course"]["token"].length <=4
          error_message = "The token you input is too short"
          raise error_message
        end
        
        # check whether there is a course with such token
        course = Course.find_by_token(params["course"]["token"])
        if course.nil?
          error_message = 'No such course with this token: ' + params["course"]["token"]
          raise error_message
        end

        # check whether this student is already in the course
        registration = CourseRegistration.where(user_id: user.id, course_id: course.id)
        if (!registration.empty?)
          error_message = 'You are already in this course'
          raise error_message
        else
          # create a new course registration record
          registration = CourseRegistration.new(user_id: user.id, course_id: course.id)
          if (registration.save)
            message = 'You have been added successfully.'
            format.html { redirect_to({controller: "student_dashboard", action: "list"}, notice: message ) }
          else
            error_message = 'Could not be added to the course due to internal error.'
            raise error_message
          end
        end
      rescue
        format.html { redirect_to({controller: "student_dashboard", action: "list"}, alert: error_message) }
      end
    end
  end

  # this is a deep clone which copies:
  # course
  # questions
  # answers associated to the copied questions
  # micro-credentials
  # micro-credential_maps which connects the copied course and copied micro-credentials
  # question_micro_credentials which connectes the copied questions and copied micro-credentials
  def clone
    #begin
      # clone course
      cloned_course = @course.dup()
      cloned_course.title = @course.title + " cloned"
      cloned_course.token = '' # course cannot have duplicated tokens
      cloned_course.save

      question_id_dict = {} # hash that maps the original_question_id => cloned_question_id
      @course.questions.each do |question|  # clone questions
        cloned_question = question.dup()
        cloned_question.copied_from_id = question.id
        cloned_question.course_id = cloned_course.id
        cloned_question.save
        question_id_dict[question.id] = cloned_question.id  # add original_question_id => cloned_question_id
      end

      question_id_dict.each_key do |original_question_id| # clone answers
        answers = Answer.where(:question_id => original_question_id)
        answers.each do |answer|
          cloned_answer = answer.dup()
          cloned_answer.question_id = question_id_dict[original_question_id] # associate to new question_id
          cloned_answer.save
        end
      end

      micro_credential_id_dict = {} # hash that maps original_mc_id => cloned_mc_id
      @course.micro_credentials.each do |micro_credential| # clone micro_credentials
        cloned_micro_credential = micro_credential.dup()
        cloned_micro_credential.save
        micro_credential_id_dict[micro_credential.id] = cloned_micro_credential.id

        # create new micro_credential_map record course <-> micro_credential
        MicroCredentialMap.new(micro_credential_id: cloned_micro_credential.id, course_id: cloned_course.id).save
      end

      @course.questions.each do |question|  # clone question_micro_credentials
        question.question_micro_credentials.each do |original_question_micro_credential|
          # find the original mc for the original question
          original_mc_id = original_question_micro_credential.micro_credential_id
          QuestionMicroCredential.new(micro_credential_id: micro_credential_id_dict[original_mc_id],
                                      question_id: question_id_dict[question.id]).save
        end
      end

      redirect_to edit_course_path(cloned_course), notice: 'Course was successfully created. You are in the page of editing the cloned course now.'
    #rescue
      #format.html { redirect_to(redirect_to_dashboard, alert: 'Course clone was not successfully done, but part of the data could have been cloned.') }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_params
      params.require(:course).permit(:title, :description, :token, :max_attempts, :close_to_attempts, :can_view_answers_after,:is_an_exam, :default_number_of_choices, :hide_from_students_after)
    end

    def redirect_to_dashboard
      if logged_in?(:admin)
        admin_dashboard_list_path
      else
        instructor_dashboard_list_path
      end
    end
end
