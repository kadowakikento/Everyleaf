class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[ new create]
  # before_action :set_user, only: %i[ show edit update ]
  # before_action :ensure_user, only: %i[ show edit update ]

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

  def edit
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
