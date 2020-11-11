# frozen_string_literal: true

module UsersHelper
  def create_user
    @current_user = User.create(email: 'admin@bridge.io', password: 'password', notifications: false)
    post '/login', { params: { user: { email: @current_user.email, password: @current_user.password } } }
    request.headers['BRIDGE-JWT'] = JSON.parse(response.body)['token']
  end
end
