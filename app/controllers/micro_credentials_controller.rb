class MicroCredentialsController < ApplicationController
  before_action :set_micro_credential, only: [:show, :edit, :update, :destroy, :clone]
  access all: [:show], instructor: {except: [:study, :index]}, admin: :all, student: [:show, :study]

  # GET /micro_credentials
  def index
    @micro_credentials = MicroCredential.all
  end

  # GET /micro_credentials/1
  def show
  end

  # GET /micro_credentials/new
  def new
    @micro_credential = MicroCredential.new
  end

  # GET /micro_credentials/1/edit
  def edit
  end

  # POST /micro_credentials
  def create
    @micro_credential = MicroCredential.new(micro_credential_params)
    # use the current_user's id as the creator_user_id of the new micro_credential
    @micro_credential.creator_user_id = current_user.id

    if @micro_credential.save
      redirect_to @micro_credential, notice: 'Micro credential was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /micro_credentials/1
  def update
    if @micro_credential.update(micro_credential_params)
      redirect_to @micro_credential, notice: 'Micro credential was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /micro_credentials/1
  def destroy
    @micro_credential.destroy
    redirect_to micro_credentials_url, notice: 'Micro credential was successfully destroyed.'
  end

  def study
    @course = Course.find(params[:course_id])
    @micro_credentials = @course.micro_credentials
  end

  def manage_course_micro_credentials
    @course = Course.find(params[:course_id])
    @used_micro_credentials = @course.micro_credentials
    # find the micro_credentials which 1) created by current user and 2) not used in any course
    @available_micro_credentials = MicroCredential.available_micro_credentials(current_user)
  end

  def associate_to_course
    course = Course.find(params[:course_id])

    # sample params:
    # {"utf8"=>"✓", "authenticity_token"=>"iebFeDd3BW66cbQlJIU21DtTvyt4HOvZMAcjgBLwxp5gsQ9IUrWjG1kB18QY4J5isaVWgPLlBTJsst7YGeyhcA==",
    # "course_id"=>"2", "id"=>["5", "7", "8"], "commit"=>"Associate", "method"=>"post"}

    # handle the case when the user does not select any check box, then there is no such key "id" in params
    if not params.key?(:id)
      redirect_to micro_credentials_manage_course_micro_credentials_path(:course_id =>course.id), alert: 'Please make sure you have selected at least one micro-credential.'
    else

      micro_credentials_to_associate = MicroCredential.find(params[:id])
      micro_credentials_to_associate.each do |micro_credential|
        if MicroCredentialMap.where(micro_credential_id: micro_credential.id, course_id: course.id).empty?
          MicroCredentialMap.new(micro_credential_id: micro_credential.id, course_id: course.id).save
        end
      end

      redirect_to micro_credentials_manage_course_micro_credentials_path(:course_id =>course.id), notice: 'New micro-credential(s) associated to this course.'
    end
  end

  def dissociate_from_course
    MicroCredentialMap.where(micro_credential_id: params[:id], course_id: params[:course_id]).delete_all

    redirect_to micro_credentials_manage_course_micro_credentials_path(:course_id => params[:course_id]), notice: 'Micro-credential(s) dissociated from this course.'
  end
  def clone
    micro_credential_copy = @micro_credential.dup()
    micro_credential_copy.title = @micro_credential.title + " cloned"
    if micro_credential_copy.save
      flash[:notice] = 'Item was successfully cloned.'
    else
      flash[:notice] = 'ERROR: Item can\'t be cloned.'
    end

    if current_user.role == :admin 
      redirect_to(admin_dashboard_list_path)
    else 
      redirect_to(instructor_dashboard_list_path)
    end
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_micro_credential
      @micro_credential = MicroCredential.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def micro_credential_params
      params.require(:micro_credential).permit(:title, :identifier, :creator_user_id, :description)
    end  
end