class ApplicationController < ActionController::API
  def render_success_message
    render json: {}
  end
end
