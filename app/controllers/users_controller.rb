require 'bcrypt'

class UsersController < ApplicationController
  include BCrypt
  before_action :set_user, only:[:show, :destroy, :update]
  before_action :encrypt_password, only:[:create, :update]

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
      render json: @user, status: :created
    else 
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy 
    #current_user.destroy
    @user.destroy
  end

  def update 
    # current_user.update(user_params)
    if @user.update(user_params)
      render json: @user
    else 
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private 

  def encrypt_password 
    params[:user][:password_hash] = BCrypt::Password.create(params[:user][:password])
  end

  def user_params 
    params.require(:user).permit(:email, :password_hash)
  end

  def set_user 
    @user = User.find_by_id(params[:id])
  end
end