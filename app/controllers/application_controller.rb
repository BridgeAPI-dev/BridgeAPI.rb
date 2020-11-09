class ApplicationController < ActionController::API
  TOKEN_HEADER = 'BRIDGE-JWT'
  def current_user
    @current_user ||= User.find_by(id: session[:id])
  end

  # decoding token, ensures token validity, finds user and sets current_user if current_user found
  def authorize_request 
    token = request.headers[TOKEN_HEADER]&.split(' ')&.last
    decoded_token = JsonWebToken.decode(token)
    user = User.find_by_id(decoded_token['user_id'])
    if user  
      @current_user = user 
    else
      render json: {}, status: 403 # Forbidden
    end 
  end
end

# {
#   user_id: 25,
#   expiration: '12-34-2025...'
# }
