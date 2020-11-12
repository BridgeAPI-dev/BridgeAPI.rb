# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bridges', type: :request do
  before do
    create_user
  end

  after do
    @current_user.destroy!
  end

  subject do
    create_bridge
  end

  describe 'handles all requests properly:' do
    it 'handles index method with valid user' do
      subject.name = 'index method bridge'
      subject.save!
      get bridges_path, headers: authenticated_token
      expect(response).to be_successful
      expect(response.body).to include subject.name
    end

    it 'doesn\'t return another user\'s bridge using index' do
      subject.name = 'index method bridge'
      subject.save!

      create_other_user
      other_bridge = create_bridge
      other_bridge.name = 'other\s bridge'
      other_bridge.user = @other_user
      other_bridge.save!

      get bridges_path, headers: authenticated_token

      expect(response).to be_successful
      expect(response.body).to_not include other_bridge.name
      expect(response.body).to include subject.name

      @other_user.destroy!
    end

    it 'handles the show method successfully' do
      subject.name = 'show method bridge'
      subject.save!
      get bridge_path(subject.id), headers: authenticated_token
      expect(response.body).to include 'show method bridge'
    end

    it 'doesn\'t return another user\'s bridge using show' do
      create_other_user
      other_bridge = create_bridge
      other_bridge.name = 'other\s bridge'
      other_bridge.user = @other_user
      other_bridge.save!

      get bridge_path(other_bridge.id), headers: authenticated_token

      expect(response).to_not be_successful

      @other_user.destroy!
    end

    it 'destroys bridges' do
      subject.save!

      delete bridge_path(subject.id), headers: authenticated_token

      expect(response).to be_successful
    end

    it 'doesnt destroy other\'s bridges' do
      create_other_user
      other_bridge = create_bridge
      other_bridge.name = 'other\s bridge'
      other_bridge.user = @other_user
      other_bridge.save!

      delete bridge_path(other_bridge.id), headers: authenticated_token

      expect(response).to_not be_successful
    end

    it 'updates bridges' do
      subject.save!

      patch bridge_path(subject.id), params: { bridge: { name: 'updated bridge ' } }, headers: authenticated_token

      expect(response).to be_successful
    end

    it 'doesnt update other\'s bridges' do
      create_other_user
      other_bridge = create_bridge
      other_bridge.name = 'other\s bridge'
      other_bridge.user = @other_user
      other_bridge.save!

      patch bridge_path(other_bridge.id), params: { bridge: { name: 'updated bridge ' } }, headers: authenticated_token

      expect(response).to_not be_successful
    end
  end
end
