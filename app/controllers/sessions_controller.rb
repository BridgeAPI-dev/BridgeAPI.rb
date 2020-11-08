require 'bcrypt'

class SessionsController < ApplicationController
  include BCrypt
  before_action :set_user, only:[:create]

  def create 
    @password = BCrypt::Password.new(@user.password)
    guess = session_params[:password]
    
    if @user && @password == guess
      session[:id] = @user.id 
      render json: @user
    else 
      render json: @user.errors, status: 403
    end 
  end

  def clear
    reset_session
  end

  private 

  def set_user 
    @user = User.find_by_email(session_params[:email])
  end

  def session_params 
    params.require(:user).permit(:email, :password)
  end
end