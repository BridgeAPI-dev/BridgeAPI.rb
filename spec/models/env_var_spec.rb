require 'rails_helper'

RSpec.describe EnvVar, type: :model do
  it 'belongs to bridge' do
    bridge = Bridge.create(name: 'My First Bridge', payload: '', inboundURL: 'https://bridgeapi.dev/b1234/inbound', outboundURL: 'https://wowservice.io/new/23847923864', method: 'post', retries: 5, delay: 15)

    envVar1 = EnvVar.create(key: 'database', value: 'a102345ij2')
    envVar2 = EnvVar.create(key: 'database_password', value: 'supersecretpasswordwow')
    bridge.env_vars << envVar1
    bridge.env_vars << envVar2
    expect(envVar1.bridge).to eq bridge 
    expect(envVar2.bridge).to eq bridge 
  end
end
