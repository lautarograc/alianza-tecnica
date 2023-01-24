class AssignEventController < ApplicationController
  before_action :set_event

  def assign_event
    if params[:names].present?
      aliadas = params[:names].map { |name| Aliada.find_by!(name: name) }
    else
      aliadas = Aliada.all
    end
    aliadas.each do |aliada|
      if aliada.assign_event(@event)
        break
      end
    end
    render json: @event, serializer: EventSerializer
  end

  def unassign_event
    @event.aliada.unassign_event(@event)
    render json: @event, serializer: EventSerializer
  end

  private

  def set_event
    @event = Event.find_by!(service_id: params[:id])
  end

  def assign_params
    params.permit(names: [])
  end
end
