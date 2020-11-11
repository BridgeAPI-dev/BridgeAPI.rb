# frozen_string_literal: true

require 'rails_helper'
require './spec/support/users_helper'
require './spec/support/bridges_helper'

RSpec.configure do |c|
  c.include UsersHelper
  c.include BridgesHelper
end

RSpec.describe Event, type: :model do
  before do
    create_user
  end

  subject do
    create_bridge
  end

  it 'belongs to bridge' do
    event1 = Event.create(
      completed: false,
      outbound_url: subject.outbound_url,
      inbound_url: subject.inbound_url,
      data: '',
      status_code: 300
    )
    event2 = Event.create(
      completed: false,
      outbound_url: subject.outbound_url,
      inbound_url: subject.inbound_url,
      data: '',
      status_code: 300
    )

    subject.events << event1
    subject.events << event2
    expect(event1.bridge).to eq subject
    expect(event2.bridge).to eq subject
  end
end
