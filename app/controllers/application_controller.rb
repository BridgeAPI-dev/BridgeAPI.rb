class ApplicationController < ActionController::API
  def render_success_message
    render json: {}
  end

  def set_bridge
    @bridge = Bridge.includes(:headers, :environment_variables, :events).find_by_id(params[:bridge_id] || params[:id])
    render json: {}, status: :unprocessable_entity unless @bridge
  end
end
