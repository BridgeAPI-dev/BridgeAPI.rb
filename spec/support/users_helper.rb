# frozen_string_literal: true

module UsersHelper
  def create_user
    @current_user = User.create(email: 'admin@bridge.io', password: 'password', notifications: false)
    @token = JsonWebToken.encode(user_id: @current_user.id)
  end

  def authenticated_token
    { 'HTTP_BRIDGE_JWT': @token }
  end
end
