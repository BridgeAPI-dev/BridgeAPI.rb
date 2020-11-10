class EnvironmentVariablesController < ApplicationController
  before_action :set_environment_variable, only: [:show, :update, :destroy]
  
  def index 
    render json: EnvironmentVariable.all
  end

  def show
    render json: @environment_variable
  end

  def create
    @environment_variable = EnvironmentVariable.new(environment_variable_params)
    @environment_variable.bridge_id = params[:bridge_id]

    if @environment_variable.save
      render_success_message
    else
      render_error_message
    end
  end

  def update
    if @environment_variable.update environment_variable_params
      render_success_message
    else
      render_error_message
    end
  end

  def destroy
    @environment_variable.destroy
    render_success_message
  end

  protected
  def environment_variable_params
    params.require(:environment_variable).permit(:key, :value)
  end

  def set_environment_variable
    @environment_variable = EnvironmentVariable.find_by_id(params[:id])
    render json: {}, status: :unprocessable_entity unless @environment_variable
  end

  def render_error_message
    render json: @environment_variable.errors, status: :internal_server_error
  end
end