class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[ new create]
  skip_before_action :login_already, only: %i[ show]
  before_action :ensure_user, only: %i[ show ]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else 
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = current_user.tasks
  end

  private

  def ensure_user
    @users = current_user.id
    @user = User.find(params[:id]) 
    redirect_to new_session_path if @user.id != @users
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
