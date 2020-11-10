class ApplicationController < ActionController::API
  attr_accessor :current_user
  TOKEN_HEADER = 'BRIDGE-JWT'
  USER_ERROR_MSG = 'ERROR: Could not find user with decoded JWT. This should not happen.'

  def authorize_request 
    binding.pry 
    token = request.headers[TOKEN_HEADER]&.split(' ')&.last
    decoded_token = JsonWebToken.decode(token)
    user = User.find(decoded_token['user_id'])
    @current_user = user 
    
  rescue ActiveRecord::RecordNotFound
    Rails.logger.error ActiveSupport::LogSubscriber.new.send(:color, USER_ERROR_MSG, :red)
    render json: {}, status: 404 # Not Found
  rescue JWT::DecodeError
    render json: {}, status: 401 # Unauthorized 
  rescue JWT::ExpiredWebToken 
    render json: {error: 'You need to log in again'}, status: 401 # unauthorized
  end
end

# Tests that activate all rescue clauses (4 tests)
  # test nil token -> DecodeError
  # test invalid token -> DecodeError 
# Test that returns the correct @current_user (1 test)
