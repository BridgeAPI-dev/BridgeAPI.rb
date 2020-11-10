class BridgesController < ApplicationController
  before_action :set_bridge, only: [:show, :update, :destroy]
  
  def index 
    render json: Bridge.all
  end

  def show
    render json: @bridge.to_json(include: [:headers, :environment_variables, :events])
  end

  def create
    @bridge = Bridge.new(bridge_params)
    @bridge.inbound_url = Bridge.generate_inbound_url
    if @bridge.save
      render_success_message
    else
      render_error_message
    end
  end

  def update
    if @bridge.update bridge_params
      render_success_message
    else
      render_error_message
    end
  end

  def destroy
    @bridge.destroy
    render_success_message
  end

  protected
  def bridge_params
    params.require(:bridge).permit(:name, :method, :retries, :delay, :outbound_url, :payload)
  end

  def render_error_message
    render json: @bridge.errors, status: :internal_server_error
  end
end