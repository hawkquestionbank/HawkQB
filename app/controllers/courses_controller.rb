class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :manage_registrations, :add_student_using_email, :drop_student]
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
      redirect_to redirect_to_dashboard, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
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


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_params
      params.require(:course).permit(:title, :description, :token)
    end

    def redirect_to_dashboard
      if logged_in?(:admin)
        admin_dashboard_list_path
      else
        instructor_dashboard_list_path
      end
    end
end
