class SessionsController < ApplicationController
  before_action :set_user

  def create
    if @user&.validate(user_params[:password])
      token = JsonWebToken.encode( {user_id: @user.id} )
      render json: {token: token}, status: 201 # Created
    else
      render json: {message: "email or password was incorrect"}, status: 403 # Forbidden
    end
  end

  private

  def set_user
    @user = User.find_by_email(user_params[:email])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
