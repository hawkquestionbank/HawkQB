class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  access all: [:show], instructor: {except: [:index]}, admin: :all

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_params
      params.require(:course).permit(:title)
    end

    def redirect_to_dashboard
      if logged_in?(:admin)
        admin_dashboard_list_path
      else
        instructor_dashboard_list_path
      end
    end
end
