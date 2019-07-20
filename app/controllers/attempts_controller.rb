class AttemptsController < ApplicationController

  access [:instructor, :admin, :student] => :all

  # GET /attemps
  def index
    @display_category = params[:category]
    @course = Course.find(params[:course_id])
    @questions = @course.questions
  end
end