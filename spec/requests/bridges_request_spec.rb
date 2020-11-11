# frozen_string_literal: true

require 'rails_helper'
require './spec/support/users_helper'
require './spec/support/bridges_helper'

RSpec.configure do |c|
  c.include UsersHelper
  c.include BridgesHelper
end

RSpec.describe 'Bridges', type: :request do
  before do
    create_user
  end

  after do 
    @current_user.destroy
  end

  subject do
    create_bridge
  end

  describe 'handles all requests properly:' do
    it 'index method' do
      subject.name = 'index method bridge'
      subject.save!
      get bridges_path, headers: authenticated_token
      expect(response).to be_successful
      expect(response.body).to include subject.name
    end

    it 'show method' do
      subject.name = 'show method bridge'
      subject.save!
      get bridge_path(subject.id), headers: authenticated_token
      expect(response.body).to include 'show method bridge'
    end
  end
end
