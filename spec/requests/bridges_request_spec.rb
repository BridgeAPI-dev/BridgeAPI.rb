# frozen_string_literal: true

require 'rails_helper'
require './spec/support/users_helper'

RSpec.configure do |c|
  c.include UsersHelper
end

RSpec.describe 'Bridges', type: :request do
  before do
    create_user
  end

  subject do
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

  describe 'handles all requests properly:' do
    it 'index method' do
      subject.name = 'index method bridge'
      subject.save!
      get bridges_path, headers: authenticated_token
      expect(response).to be_successful
      expect(response.body).to include('index method bridge')
    end

    it 'show method' do
      subject.name = 'show method bridge'
      subject.save!
      get bridge_path(subject.id), headers: authenticated_token
      expect(response.body).to include 'show method bridge'
    end
  end
end
