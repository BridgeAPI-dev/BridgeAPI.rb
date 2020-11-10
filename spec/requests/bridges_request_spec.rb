require 'rails_helper'

RSpec.describe "Bridges", type: :request do
  describe "handles all requests properly:" do
    it 'index method' do 
      bridge = Bridge.create(
        name: 'index method bridge',
        payload: '',
        inbound_url: Bridge.generate_inbound_url,
        outbound_url: "doggoapi.io/" + Bridge.generate_inbound_url, 
        method: 'POST', 
        retries: 5, 
        delay: 15
      )
      get bridges_path
      expect(response).to be_successful
      expect(response.body).to include("index method bridge")
    end

    it 'show method' do
      bridge = Bridge.create(
        name: 'show method bridge',
        payload: '',
        inbound_url: Bridge.generate_inbound_url,
        outbound_url: "doggoapi.io/" + Bridge.generate_inbound_url, 
        method: 'POST', 
        retries: 5, 
        delay: 15
      )
      get bridge_path(bridge.id)
      expect(response.body).to include 'show method bridge'
    end
  end
end