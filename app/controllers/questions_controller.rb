class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_type
  access all: [:show], instructor: {except: [:index]}, admin: :all

  # GET /questions
  def index
    @questions = type_class.all
  end

  # GET /questions/1
  def show
    @answers = @question.answers.order("id")
  end

  # GET /questions/new
  def new
    @question = Question.new
    @answers = []
    4.times{ @answers.append(Answer.new) }
  end

  # GET /questions/1/edit
  def edit
    @answers = @question.answers.order("id")
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    @question.type = params[:type]
    @question.creator_user_id = current_user.id

    if @question.save

      correct_keys = params[:optionsRadios]

      params[:quiz_question_choices].keys.each do |choice_key|
        a = Answer.new(txt: params[:quiz_question_choices][choice_key][:txt], is_correct: (choice_key == correct_keys), question_id: @question.id)
        a.save
      end

      redirect_to @question, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)

      correct_keys = params[:optionsRadios]

      i = 1
      @question.answers.each do |answer|
        answer.update_attributes(is_correct: (i.to_s == correct_keys), txt: params[:quiz_question_choices][i.to_s][:txt])
        i+=1
      end

      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    redirect_to questions_url, notice: 'Question was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      if params[:commit].start_with?("Update")
        question_type = params[:type].to_sym
        params.require(question_type).permit(:title, :description, :type)
      else
        params.require(:question).permit(:title, :description, :type)
      end
    end

    def set_type
      @type = type
    end

    def type
      Question.types.include?(params[:type]) ? params[:type].camelize : "Question"
    end

    def type_class
      type.constantize
    end
end
