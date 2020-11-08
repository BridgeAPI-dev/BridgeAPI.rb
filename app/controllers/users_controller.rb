# require 'bcrypt'

class UsersController < ApplicationController
  # include BCrypt
  before_action :set_user, only:[:show, :destroy, :update]
  # before_action :hash_password, only:[:create, :update]

  def show 
    # if current_user
      render json: @user
      # else 
      # login_page 
  end

  def create 
    @user = User.new(user_params)
    if @user.save! 
      session[:id] = @user.id 
      render json: @user, status: 201 # Created
    else 
      render json: @user.errors, status: 422 # Unprocessable Entity
    end
  end

  def destroy 
    #current_user.destroy
    @user.destroy
    render status: 204 # No Content 
  end

  def update 
    # current_user.update(user_params)
    if @user.update(user_params)
      render json: @user, status: 204 # No Content 
    else 
      render json: @user.errors, status: 400 # Bad Request
    end
  end

  private 

  def hash_password 
    params[:user][:password] = BCrypt::Password.create(params[:user][:password])
  end

  def user_params 
    params.require(:user).permit(:email, :password)
  end

  def set_user 
    @user = User.find_by_id(params[:id])
  end
end