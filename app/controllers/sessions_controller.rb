class SessionsController < ApplicationController
  before_action :set_user

  def create
    if @user&.validate(session_params[:password])
      session[:id] = @user.id
      render json: @user, status: 200 # OK 
    else
      render json: @user.errors, status: 403 # Forbidden
    end
  end

  private

  def set_user
    @user = User.find_by_email(session_params[:email])
  end

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
