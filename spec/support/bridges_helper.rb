# frozen_string_literal: true

module BridgesHelper
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
