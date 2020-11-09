class UsersController < ApplicationController
  before_action :authorize_request, only: [:show, :destroy, :update]

  def show
    render json: self.current_user.condensed, status: 200 
  end

  def create
    user = User.new(user_params)
    if user.save!
      self.current_user = user 
      token = JsonWebToken.encode( {user_id: self.current_user.id} )
      render json: {user: self.current_user.condensed, token: token}, status: 201 # Created
    else
      render json: {}, status: 422 # Unprocessable Entity
    end
  end

  def destroy
    self.current_user.destroy 
  end
  
  def update
    if self.current_user.update(user_params)
      render json: self.current_user.condensed, status: 204 # No Content
    else
      render json: {}, status: 400 # Bad Request
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :notifications)
  end
end
