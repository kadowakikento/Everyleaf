class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required
  before_action :login_already

  private

  def login_required
    redirect_to new_session_path unless current_user
  end

  def login_already
    redirect_to user_path(current_user.id) if current_user
  end
end
