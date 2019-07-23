class AttemptsController < ApplicationController

  access instructor: :all, admin: :all, student: :all

  # GET /attemps
  def index
    @display_category = params[:category]
    @course = Course.find(params[:course_id])
    @questions = @course.questions
  end

  def new
    @attempt = Attempt.new
    @attempt.created_at = Time.new
    @question = Question.find(params[:question_id])
    @answers = @question.answers
  end

  def create
    @attempt = Attempt.new(attempt_params)
    @attempt.answer_id = params[:quiz_question_choices][:selected_index]
    @question = Question.find(params[:attempt][:question_id])

    if @attempt.save
      redirect_to attempts_path(:category => "all", :course_id =>@question.course_id ), notice: 'Course was successfully created.'
    else
      render :new
    end

  end

  private
  # Only allow a trusted parameter "white list" through.
  def attempt_params
    params.require(:attempt).permit(:user_id, :question_id, :created_at)
  end

end