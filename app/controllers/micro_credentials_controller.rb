class MicroCredentialsController < ApplicationController
  before_action :set_micro_credential, only: [:show, :edit, :update, :destroy]
  access all: [:index, :show, :new, :edit, :create, :update, :destroy], user: :all

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
