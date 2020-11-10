require 'rails_helper'

RSpec.describe EnvironmentVariable, type: :model do
  subject { 
    Bridge.create(
      name: 'bridge',
      payload: '',
      inbound_url: Bridge.generate_inbound_url,
      outbound_url: "doggoapi.io/" + Bridge.generate_inbound_url, 
      method: 'POST', 
      retries: 5, 
      delay: 15 
    )
  }

  it 'belongs to bridge' do
    EnvironmentVariable1 = EnvironmentVariable.create(key: 'database', value: 'a102345ij2')
    EnvironmentVariable2 = EnvironmentVariable.create(key: 'database_password', value: 'supersecretpasswordwow')
    subject.env_vars << EnvironmentVariable1
    subject.env_vars << EnvironmentVariable2
    expect(EnvironmentVariable1.bridge).to eq subject 
    expect(EnvironmentVariable2.bridge).to eq subject 
  end
end
