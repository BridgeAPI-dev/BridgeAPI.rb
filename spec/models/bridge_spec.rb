# frozen_string_literal: true

require 'rails_helper'
require './spec/support/users_helper'
require './spec/support/bridges_helper'

RSpec.configure do |c|
  c.include UsersHelper
  c.include BridgesHelper
end

RSpec.describe Bridge, type: :model do
  before do
    create_user
  end

  after do 
    @current_user.destroy
  end

  subject do
    create_bridge
  end

  it 'has many env vars' do
    subject.env_vars << EnvironmentVariable.create(
      key: 'database',
      value: 'a102345ij2'
    )
    subject.env_vars << EnvironmentVariable.create(
      key: 'database_password',
      value: 'supersecretpasswordwow'
    )
    expect(subject.env_vars.count).to eq 2
  end

  it 'has many headers' do
    subject.headers << Header.create(
      key: 'X_API_KEY',
      value: 'ooosecrets'
    )
    subject.headers << Header.create(
      key: 'Authentication',
      value: 'Bearer 1oij2oubviu3498'
    )
    expect(subject.headers.count).to eq 2
  end

  it 'has many events' do
    5.times do
      subject.events << Event.create(
        completed: false,
        outbound_url: subject.outbound_url,
        inbound_url: subject.inbound_url,
        data: '',
        status_code: 300
      )
    end
    expect(subject.events.count).to eq 5
  end
end
