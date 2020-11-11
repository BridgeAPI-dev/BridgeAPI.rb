# frozen_string_literal: true

require 'rails_helper'
require './spec/support/main_helper'

RSpec.configure do |c|
  c.include MainHelper
end

RSpec.describe EnvironmentVariable, type: :model do
  subject do
    create_bridge
  end

  it 'belongs to bridge' do
    environment_variable1 = EnvironmentVariable.create(key: 'database', value: 'a102345ij2')
    environment_variable2 = EnvironmentVariable.create(key: 'database_password', value: 'supersecretpasswordwow')
    subject.env_vars << environment_variable1
    subject.env_vars << environment_variable2
    expect(environment_variable1.bridge).to eq subject
    expect(environment_variable2.bridge).to eq subject
  end
end
