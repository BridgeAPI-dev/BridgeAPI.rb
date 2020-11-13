# frozen_string_literal: true

class BridgesController < ApplicationController
  before_action :authorize_request
  before_action :set_bridge, only: %i[show update destroy]

  def index
    render_message message: @current_user.bridges.all
  end

  def show
    render_message message: @bridge.to_json(include: %i[headers environment_variables events])
  end

  def create
    @bridge = Bridge.new(bridge_params)
    @bridge.populate_data(@current_user, params[:test_payload], params[:payload])

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

  def bridge_params
    params.require(:bridge).permit(
      :name,
      :method,
      :retries,
      :delay,
      :outbound_url,
      :payload,
      :data,
      headers_attributes: %i[key value],
      environment_variables_attributes: %i[key value]
    )
  end

  def set_bridge
    @bridge = Bridge.includes(:events, :headers, :environment_variables).find_by(id: params[:id], user: @current_user)
    render_message status: :unprocessable_entity unless @bridge
  end
end
