class HeadersController < ApplicationController 
  before_action :set_header, only: [:show, :update, :destroy]
  
  def index 
    render json: Header.all
  end

  def show
    render json: @header
  end

  def create
    @header = Header.new(header_params)
    @header.bridge_id = params[:bridge_id]

    if @header.save
      render_success_message
    else
      render_error_message
    end
  end

  def update
    if @header.update header_params
      render_success_message
    else
      render_error_message
    end
  end

  def destroy
    @header.destroy
    render_success_message
  end

  protected
  def header_params
    params.require(:header).permit(:key, :value)
  end

  def set_header
    @header = Header.find_by_id(params[:id])
    render json: {}, status: :unprocessable_entity unless @header
  end

  def render_error_message
    render json: @header.errors, status: :internal_server_error
  end
end