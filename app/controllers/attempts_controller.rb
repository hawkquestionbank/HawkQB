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
    @course = Course.find(params[:course_id])
  end

  def create
    @attempt = Attempt.new(attempt_params)
    @attempt.answer_id = params[:quiz_question_choices][:selected_index]
    @question = Question.find(params[:attempt][:question_id])

    if not @question.valid_attempt?(@attempt)
      redirect_to ({controller: "attempts", action: "new", course_id: params[:course_id], question_id: @question.id}), alert:'ERROR: invalid answer, please make sure you have answered the question.'
    elsif not @question.grade @attempt
      redirect_to ({controller: "attempts", action: "new", course_id: params[:course_id], question_id: @question.id}), alert:'ERROR: invalid answer, please make sure you have answered the question.'
    elsif @attempt.save
      #@question.grade(@attempt)
      redirect_to attempts_path(:category => "all", :course_id =>params[:course_id] ), notice: 'Your answer was successfully submitted.'
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