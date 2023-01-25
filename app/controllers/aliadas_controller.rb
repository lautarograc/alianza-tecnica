# frozen_string_literal: true

class AliadasController < ApplicationController
  before_action :set_aliada, only: %i[show edit update destroy]

  # create
  def create
    @aliada = Aliada.new(aliada_params)
    if @aliada.save
      render json: AliadaSerializer.new(@aliada), status: :created
    else
      render json: { errors: @aliada.errors }, status: :unprocessable_entity
    end
  end

  # index
  def index
    @aliadas = Aliada.all
    if params[:include_calendar].present?
      render json: AliadaSerializer.new(@aliadas, { params: { include_calendar: true } })
    else
      render json: AliadaSerializer.new(@aliadas)
    end
  end

  # show
  def show
    if params[:include_calendar].present?
      render json: AliadaSerializer.new(@aliada, { params: { include_calendar: true } })
    else
      render json: AliadaSerializer.new(@aliada)
    end
  end

  private

  def set_aliada
    @aliada = Aliada.find(params[:id])
  end

  def aliada_params
    params.require(:aliada).permit(:name)
  end
end
