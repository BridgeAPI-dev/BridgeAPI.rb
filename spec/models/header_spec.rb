require 'rails_helper'

RSpec.describe Header, type: :model do
  it 'belongs to bridge' do
    bridge = Bridge.create(name: 'My First Bridge', payload: '', inboundURL: 'https://bridgeapi.dev/b1234/inbound', outboundURL: 'https://wowservice.io/new/23847923864', method: 'post', retries: 5, delay: 15)

    header1 = Header.create(key: 'X_API_KEY', value: 'ooosecrets')
    header2 = Header.create(key: 'Authentication', value: 'Bearer 1oij2oubviu3498')
    bridge.env_vars << header1
    bridge.env_vars << header2
    expect(header1.bridge).to eq bridge 
    expect(header2.bridge).to eq bridge 
  end
end
