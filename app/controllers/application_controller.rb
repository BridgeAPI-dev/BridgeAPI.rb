class ApplicationController < ActionController::API
  attr_accessor :current_user
  TOKEN_HEADER = 'BRIDGE-JWT'

  def authorize_request 
    token = request.headers[TOKEN_HEADER]&.split(' ')&.last
    decoded_token = JsonWebToken.decode(token)
    begin 
      user = User.find(decoded_token['user_id'])
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: 404 # Not Found
    else 
      @current_user = user 
    end 

    # if user  
    #   @current_user = user 
    # else    #   render json: {}, status: 403 # Forbidden
    # end 
  end
end
