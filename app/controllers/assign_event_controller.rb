class AssignEventController < ApplicationController
  before_action :set_event

  def assign_event
    puts "event: #{@event}"
    @names = params[:names] ? params[:names] : []
    AliadaAssignationWorker.perform_async(@event.id, @names)
    render json: EventSerializer.new(@event), status: :accepted
  end

  def unassign_event
    @event.aliada.unassign_event(@event)
    render json: EventSerializer.new(@event), status: :accepted
  end

  private

  def set_event
    @event = Event.find_by!(service_id: params[:id])
  end

  def assign_params
    params.permit(:names)
  end
end
