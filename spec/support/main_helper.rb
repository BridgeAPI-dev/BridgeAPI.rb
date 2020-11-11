# frozen_string_literal: true

module MainHelper
  def create_user
    @current_user = User.create(email: 'admin@bridge.io', password: 'password', notifications: false)
    @token = JsonWebToken.encode(user_id: @current_user.id)
  end

  def authenticated_token
    { 'HTTP_BRIDGE_JWT': @token }
  end

  def create_bridge
    Bridge.create(
      user: @current_user,
      name: 'bridge',
      payload: '',
      outbound_url: "doggoapi.io/#{Bridge.generate_inbound_url}",
      method: 'POST',
      retries: 5,
      delay: 15
    )
  end
end
