class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy, :update]

  def show
    if @user
      render json: @user, status: 200 # OK 
    else
      render json: {response: 'Unauthorized'}, status: 401
    end
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
    @user.destroy 
  end
  
  def update
    if @user.update(user_params)
      render json: @user, status: 204 # No Content
    else
      render json: @user.errors, status: 400 # Bad Request
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = current_user
  end
end
