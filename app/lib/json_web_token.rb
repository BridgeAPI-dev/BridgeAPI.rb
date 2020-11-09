class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  # Expects a hash {user_id: id}
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    begin 
      JWT.encode(payload, SECRET_KEY)
    rescue JWT::EncodeError
      render json: {}, status: 401 # Unauthorized 
    end 
  end

  def self.decode(token)
    begin 
      decoded = JWT.decode(token, SECRET_KEY).first 
      current = DateTime.now 
      raise JWT::ExpiredWebToken if current > decoded['exp'] 
    rescue JWT::DecodeError
      render json: {}, status: 401 # Unauthorized 
    rescue JWT::ExpiredWebToken 
      render json: {error: 'You need to log in again'}, status: 401 # unauthorized
    else  
      decoded
    end 
  end
end