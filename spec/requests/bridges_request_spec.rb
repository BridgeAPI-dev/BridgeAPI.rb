require 'rails_helper'

RSpec.describe "Bridges", type: :request do
  describe "handles all requests properly:" do
    it 'index method' do 
      bridge = Bridge.create(
        name: 'index method bridge',
        payload: '',
        inbound_url: Bridge.generate_inbound_url,
        outbound_url: "doggoapi.io/" + Bridge.generate_inbound_url, 
        method: 'POST', 
        retries: 5, 
        delay: 15
      )
      get bridges_path
      expect(response).to be_successful
      expect(response.body).to include("index method bridge")
    end

    it 'show method' do
      bridge = Bridge.create(
        name: 'show method bridge',
        payload: '',
        inbound_url: Bridge.generate_inbound_url,
        outbound_url: "doggoapi.io/" + Bridge.generate_inbound_url, 
        method: 'POST', 
        retries: 5, 
        delay: 15
      )
      get bridge_path(bridge.id)
      expect(response.body).to include 'show method bridge'
    end
  end
end

require 'rails_helper'

# RSpec.describe User, type: :model do 
#   subject { User.new(
#     email: 'mail@mail.com',
#     password: 'password'
#   ) 
# } 
  
#   it 'is valid when passed a password and valid email' do 
#     expect(subject).to be_valid
#   end

#   it 'is invalid without password_digest' do 
#     subject.password = nil 
#     expect(subject).to_not be_valid 
#   end

#   it 'is invalid without email' do 
#     subject.email = nil 
#     expect(subject).to_not be_valid 
#   end

#   it 'is invalid with invalid email format' do 
#     subject.email = 'invalid'
#     expect(subject).to_not be_valid 
#   end

#   it 'is invalid with duplicate email at account creation' do 
#     subject.save 
#     subject2 = User.new(email: 'mail@mail.com', password: 'password')
#     expect(subject2).to_not be_valid 
#   end

#   it 'is invalid if notifications set to nil' do 
#     subject.notifications = nil
#     expect(subject).to_not be_valid 
#   end

# end