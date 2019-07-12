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

      correct_keys = correct_keys_from_params
      # multipleselect/new:
      # {"utf8"=>"✓", "authenticity_token"=>"S+V98di1oBuB2tGZHCUis6U+6YRL3p4aPRIY1S7TEthu6mRYqNK+dY5osuAsClhwKegifc44lDexlCno1uITjw==",
      # "question"=>{"title"=>"MS4", "description"=>"MC4"}, "type"=>"MultipleSelect",
      # "quiz_question_choices"=>{"1"=>{"correctindex"=>"1", "txt"=>"C1"}, "2"=>{"correctindex"=>"2", "txt"=>"C2"}, "3"=>{"txt"=>"C3"}, "4"=>{"txt"=>"C4"}},
      # "commit"=>"Create Question"}

      # multiplechoice/new
      # {"utf8"=>"✓", "authenticity_token"=>"SuNCm0Q2SWHc8RSDWbKohhVG2KdyYns8azOmaDUxut9v7FsyNFFXD9NDd/ppndJFmZATXveEcRHntZdVzQC7iA==",
      # "question"=>{"title"=>"MC33", "description"=>"MC33 DESC"}, "type"=>"MultipleChoice",
      # "quiz_question_choices"=>{"1"=>{"txt"=>"X1"}, "2"=>{"txt"=>"X2"}, "3"=>{"txt"=>"X3"}, "4"=>{"txt"=>"X4"}},
      # "optionsRadios"=>"2",
      # "commit"=>"Create Question"}
      params[:quiz_question_choices].keys.each do |choice_key|
        a = Answer.new(txt: params[:quiz_question_choices][choice_key][:txt], is_correct: (correct_keys.include? choice_key), question_id: @question.id)
        a.save
      end

      redirect_to @question, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  # find the correct choice's index from params,
  # return a list of indexes of correct choices as keys in params["quiz_question_choices"]
  def correct_keys_from_params
    correct_keys = []

    if params[:type].camelize == "MultipleChoice"
      # take the only choice
      correct_keys << params[:optionsRadios]
    elsif params[:type].camelize == "MultipleSelect"
      # visit all the hashes in params["quiz_question_choices"] and keep the correct ones
      params[:quiz_question_choices].keys.each do |choice_key|
        if params[:quiz_question_choices][choice_key].key?("correctindex")
          correct_keys << choice_key
        end
      end
    end

    correct_keys
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)

      correct_keys = correct_keys_from_params

      # multipleselect/edit
      # {"utf8"=>"✓", "authenticity_token"=>"En1mK0MQHO6eTSxh1Cge6JrbNOmCW4h8ENObI46zgakPJpx/VX7MpT/SV1a4e22o0nx/btO4qajONyllqftDmA==",
      # "multiple_select"=>{"title"=>"MS4", "description"=>"MC4"}, "type"=>"multiple_select",
      # "quiz_question_choices"=>{"1"=>{"correctindex"=>"1", "txt"=>"C1"}, "2"=>{"correctindex"=>"2", "txt"=>"C2"}, "3"=>{"correctindex"=>"3", "txt"=>"C3"}, "4"=>{"txt"=>"C4"}},
      # "commit"=>"Update Multiple select", "id"=>"37"}
      #
      # multiplechoince/edit
      #  {"utf8"=>"✓", "authenticity_token"=>"9RcRxZiNhn2j1hlAnaBmIG5nkDZZCCOO6TvBwDNz/jyqm+fQFw3YnMgcSQunPmBgVidQmlKQ/Ca03MtkdJeiJA==",
      # "multiple_choice"=>{"title"=>"MC33", "description"=>"MC33 DESC"}, "type"=>"multiple_choice",
      # "quiz_question_choices"=>{"1"=>{"txt"=>"X1"}, "2"=>{"txt"=>"X2"}, "3"=>{"txt"=>"X3"}, "4"=>{"txt"=>"X4"}},
      # "optionsRadios"=>"3",
      # "commit"=>"Update Multiple choice", "id"=>"38"}

      i = 1
      @question.answers.each do |answer|
        answer.update_attributes(is_correct: (correct_keys.include? i.to_s), txt: params[:quiz_question_choices][i.to_s][:txt])
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
