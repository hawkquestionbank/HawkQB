class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  access admin: :all

  # GET /users
  def index
    # this view should be removed later - we used dashboards instead
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    filtered_params = user_params

    # if not @user.valid_password?(filtered_params[:current_password])
    #   redirect_to @user, alert: 'Incorrect password'
    # else
    #   filtered_params.delete(:current_password)
    # end

    if filtered_params[:current_password].blank?
      filtered_params.delete(:password)
      filtered_params.delete(:current_password)
      filtered_params.delete(:password_confirmation)
    end

    if filtered_params.has_key?(:current_password) & @user.update_with_password(filtered_params)
      redirect_to users_path, notice: 'User was successfully updated. (password also updated)'
    elsif not filtered_params.has_key?(:current_password) & @user.update_without_password(filtered_params)
      redirect_to users_path, notice: 'User was successfully updated. (password not updated)'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_path, notice: 'User was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :current_password, :password, :password_confirmation,:role)
  end

end
