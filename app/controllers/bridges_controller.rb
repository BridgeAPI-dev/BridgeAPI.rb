class BridgesController < ApplicationController
  before_action :set_bridge, only: [:show]
  
  def index 
    render json: Bridge.all
  end

  def show
    if (@bridge)
      render json: @bridge.to_json(include: [:headers, :environment_variables, :events])
    else
      render json: {}
    end
  end

  protected
  def bridge_params
  end

  def set_bridge
    @bridge = Bridge.includes(:headers, :environment_variables, :events).find_by_id(params[:id])
  end
end