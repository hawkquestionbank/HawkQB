class AttemptsController < ApplicationController

  access instructor: :all, admin: :all, student: [:index, :new, :create, :show, :redirect_to_attempts_show]

  # GET /attemps
  def index
    @display_category = params[:category]
    @course = Course.find(params[:course_id])
    if @display_category == "open"
      @questions = current_user.my_open_questions @course
    elsif @display_category == "closed"
      @questions = current_user.my_closed_questions @course
    else
      @questions = @course.questions
    end

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
    @question = Question.find(params[:attempt][:question_id])
    if @question.type == "MultipleChoice"
      @attempt.answer_id = params[:quiz_question_choices][:selected_index]
    elsif @question.type == "MultipleSelect"
      #{"utf8"=>"✓", "authenticity_token"=>"UNuBAnyln83j5CU+J9SFko7xFgFwIar50kW5drSaeeItpT0ImMzIkq0Jyq1aoxASWO4feeqyOHyF31p9scpACQ==",
      # "quiz_question_choices"=>{"91"=>{"selected_index"=>"91"}, "94"=>{"selected_index"=>"94"}},
      # "course_id"=>"7", "attempt"=>{"user_id"=>"4", "question_id"=>"47", "created_at"=>"2019-08-04 01:47:35 -0400"},
      # "commit"=>"Create Attempt"}
      if params.key?("quiz_question_choices")
        @attempt.answer_hash = {"answer_ids"=>params["quiz_question_choices"].keys}
      else
        @attempt.answer_hash = {"answer_ids"=>[]}
      end
    end

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

  def show
    @attempt = Attempt.find(params[:id])
    @question = @attempt.question
    @course = @question.course
    @answers = @question.answers
    @micro_credentials_required = @question.micro_credentials
  end

  def redirect_to_attempts_show
    user_id = params[:user_id]
    question_id = params[:question_id]
    latest_attempt = Attempt.where(:user_id=>user_id, :question_id=>question_id).order("id desc").first
    redirect_to attempt_path latest_attempt
  end

  def view_scores
    @course = Course.find(params[:course_id])
  end

  private
  # Only allow a trusted parameter "white list" through.
  def attempt_params
    params.require(:attempt).permit(:user_id, :question_id, :created_at)
  end

end