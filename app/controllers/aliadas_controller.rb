class AliadasController < ApplicationController
  before_action :set_aliada, only: %i[ show edit update destroy ]

  #create
  def create
    @aliada = Aliada.new(aliada_params)
    if @aliada.save
      render json: @aliada, status: :created
    else
      render json: { errors: @aliada.errors }, status: :unprocessable_entity
    end
  end

  private

  def aliada_params
    params.require(:aliada).permit(:name)
  end
end
