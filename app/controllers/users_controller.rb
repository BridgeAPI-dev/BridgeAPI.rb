class UsersController < ApplicationController
  before_action :authorize_request, only: [:show, :destroy, :update]

  def show
    # TODO - restrict to only user_name, notifications_boolen 
    render json: @current_user, status: 200 
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      session[:id] =  JsonWebToken.encode( {user_id: @user.id} )
      token = JsonWebToken.encode( {user_id: @user.id} )
      render json: {user: @user, token: token}, status: 201 # Created
    else
      render json: @user.errors, status: 422 # Unprocessable Entity
    end
  end

  def destroy
    @current_user.destroy 
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
end
