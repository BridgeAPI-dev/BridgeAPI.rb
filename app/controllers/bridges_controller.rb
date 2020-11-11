# frozen_string_literal: true

class BridgesController < ApplicationController
  before_action :authorize_request
  before_action :set_bridge, only: %i[show update destroy]

  def index
    render json: @current_user.bridges.all
  end

  def show
    render json: @bridge.to_json(include: %i[headers environment_variables events])
  end

  def create
    @bridge = Bridge.new(bridge_params)
    @bridge.user = @current_user

    if @bridge.save
      render_success_message(:created)
    else
      render_error_message(@bridge.errors)
    end
  end

  def update
    if @bridge.update bridge_params
      render_success_message
    else
      render_error_message(@bridge.errors)
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

  def set_bridge
    @bridge = Bridge.includes(:events, :headers, :environment_variables).find_by(id: params[:id], user: @current_user)
    render json: {}, status: :unprocessable_entity unless @bridge
  end
end
