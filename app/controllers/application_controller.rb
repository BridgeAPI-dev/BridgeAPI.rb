class ApplicationController < ActionController::API
  def render_success_message(status = :ok)
    render json: {}, status: status
  end
end
