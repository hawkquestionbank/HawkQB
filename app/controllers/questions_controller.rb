class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :associate_micro_credentials, :dissociate_micro_credentials]
  before_action :set_type
  access all: [:show], instructor: :all, admin: :all

  # GET /questions
  def index
    if current_user.role == :admin
      @questions = type_class.all
      questions_accessible = Question.all
    else
      @questions = type_class.where(creator_user_id: current_user.id)
      questions_accessible = Question.where(creator_user_id: current_user.id)
    end
    @quetion_type_counts = questions_accessible.group(:type).count

  end

  # GET /questions/1
  def show
    @answers = @question.answers.order("id")
    @course = @question.course
    @micro_credentials_required =  @question.micro_credentials
  end

  # GET /questions/new
  def new
    @question = Question.new
    @answers = []
    4.times{ @answers.append(Answer.new) }

    @course_options = current_user.own_courses.map{ |c| [ c.title, c.id ] }
    @course_options.unshift(["---", nil])
  end

  # GET /questions/1/edit
  def edit
    @answers = @question.answers.order("id")
    @course_options = current_user.own_courses.map{ |c| [ c.title, c.id ] }
    @course_options.unshift(["---", nil])
    @course = @question.course
    @question_micro_credential_ids = @question.micro_credentials.map(&:id)
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    @question.course_id = params["course_id"]
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
    @question.course_id = params["course_id"]
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

  # manage question associated to a course
  def manage_questions
    @course = Course.find(params[:course_id])
    @questions = @course.questions
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    redirect_to questions_url, notice: 'Question was successfully destroyed.'
  end

  def associate_micro_credentials
    # sample prarams
    # {"utf8"=>"✓", "authenticity_token"=>"AaUIQ3xGVSe78NOc5xjHZy/HXn6JJCMu0nO2JdUUBFCO+ZWq47XoU6Y77pxOH8LIY2XBcPPeXVUFqnVGAvgocg==",
    # "id"=>"46", "micro_credential_id"=>["7", "8"], "commit"=>"Associate", "method"=>"post"}
    course = @question.course

    if not params.key?(:micro_credential_id)
      redirect_to micro_credentials_manage_course_micro_credentials_path(:course_id =>course.id), alert: 'Please make sure you have selected at least one micro-credential.'
    else

      micro_credentials_to_associate = MicroCredential.find(params[:micro_credential_id])
      micro_credentials_to_associate.each do |micro_credential|
        if QuestionMicroCredential.where(micro_credential_id: micro_credential.id, question_id: @question.id).empty?
          QuestionMicroCredential.new(micro_credential_id: micro_credential.id, question_id: @question.id).save
        end
      end

      redirect_to questions_manage_questions_path(course_id: course.id), notice: 'New micro-credential(s) associated to this question.'
    end
  end

  def dissociate_micro_credentials
    course = @question.course
    QuestionMicroCredential.where(micro_credential_id: params[:micro_credential_id], question_id: params[:id]).delete_all
    redirect_to questions_manage_questions_path(course_id: course.id), notice: 'Micro-credential(s) dissociated from this course.'
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
