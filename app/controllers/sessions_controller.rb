class SessionsController < ApplicationController
  def create  
    user = User.find_by_email(params[:email])
    if user && user.password == params[:password]
      session[:user_id] = user.id 
      render json: @user, status: :logged_in
    else 
      render json: 'hi'
    end 
  end

  def destroy   
    # Delete session
    # return a confirmation 
  end

  private 

  def user_params 
    params.require(:user).permit(:email, :password)
  end
end