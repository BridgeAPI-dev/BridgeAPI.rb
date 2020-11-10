# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bridges', type: :request do
  subject do
    Bridge.create(
      name: 'bridge',
      payload: '',
      inbound_url: Bridge.generate_inbound_url,
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
      get bridges_path
      expect(response).to be_successful
      expect(response.body).to include('index method bridge')
    end

    it 'show method' do
      subject.name = 'show method bridge'
      subject.save!
      get bridge_path(subject.id)
      expect(response.body).to include 'show method bridge'
    end
  end
end
