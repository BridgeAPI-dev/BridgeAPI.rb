class UsersController < ApplicationController
  before_action :authorize_request, only: [:show, :destroy, :update]

  def show
    render json: @current_user.condensed, status: 200 
  end

  def create
    user = User.new(user_params)
    begin  
      user.save!
      @current_user = user 
      token = JsonWebToken.encode( {user_id: @current_user.id} )
    rescue ActiveRecord::RecordInvalid 
      render json: {error: 'email or password is invalid'}, status: 422 # Unprocessable Entity
    else 
      render json: {user: @current_user.condensed, token: token}, status: 201 # Created
    end
  end

  def destroy
    @current_user.destroy 
  end
  
  def update
    if @current_user.update(user_params)
      render json: @current_user.condensed, status: 204 # No Content
    else
      render json: {}, status: 400 # Bad Request
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :notifications)
  end
end 
