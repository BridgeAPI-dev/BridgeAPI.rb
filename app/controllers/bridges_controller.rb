# frozen_string_literal: true

class BridgesController < ApplicationController
  before_action :authorize_request
  before_action :set_bridge, only: %i[show update destroy]

  def index
    @bridges = @current_user.bridges.all.map(&:add_event_info)

    render_message message: { bridges: @bridges }
  end

  def show
    render json: { bridge: @bridge }, include: %i[headers environment_variables events], status: :ok
  end

  def create
    @bridge = Bridge.new(bridge_params)
    @bridge.user = @current_user

    if @bridge.save
      render_message message: { id: @bridge.id }, status: :created
    else
      render_message message: @bridge.errors, status: :bad_request
    end
  end

  def update
    if @bridge.update bridge_params
      render_message
    else
      render_message message: @bridge.errors, status: :bad_request
    end
  end

  def destroy
    @bridge.destroy
    render_message
  end

  protected

  # rubocop:disable Metrics/MethodLength
  def bridge_params
    params.require(:bridge).permit(
      :title,
      :method,
      :retries,
      :delay,
      :outbound_url,
      :payload,
      data: %i[payload test_payload],
      headers_attributes: %i[id key value],
      environment_variables_attributes: %i[id key value]
    )
  end
  # rubocop:enable Metrics/MethodLength

  def set_bridge
    @bridge = Bridge.includes(:events, :headers, :environment_variables).find_by(id: params[:id], user: @current_user)
    render_message status: :unprocessable_entity unless @bridge
  end
end
