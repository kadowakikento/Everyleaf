class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)
  before_action :ensure_user
  skip_before_action :login_already

  def index
    @users = User.all.order(:id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザーを作成しました"
    else
      render :new
    end
  end

  def show
    @tasks = @user.tasks
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザーを編集しました"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました"
    else  
      redirect_to admin_users_path
    end
  end

  private

  def ensure_user
    @users = current_user
    redirect_to tasks_path, notice: "管理者以外はアクセスできません" if @user.admin == false
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation, :admin)
  end
end

