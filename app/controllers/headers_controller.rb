# frozen_string_literal: true

class HeadersController < ApplicationController
  before_action :authorize_request
  before_action :set_header

  def destroy
    @header.destroy
    render_message
  end

  protected

  def set_header
    @header = Header.includes(:bridge).find_by(id: params[:id])
    render_message status: :unprocessable_entity unless @header&.bridge&.user_id == @current_user.id
  end
end
