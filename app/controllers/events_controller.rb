class EventsController < ApplicationController
  def index
    @events = Event.all
    render json: @events, each_serializer: EventSerializer
  end

  def show
    @event = Event.find_by!(service_id: params[:id])
    render json: @event, serializer: EventSerializer
  end

  def create
    @event = Event.new
    @event.starts = event_params.fetch(:date_program)
    @event.ends = @event.starts + event_params.fetch(:duration).to_i.hours
    @event.service_id = event_params.fetch(:id)
    if @event.save
      # Create a sidekiq job for creating a new "travel" event
      TravelEventJob.perform_async(@event.id)
      render json: @event, serializer: EventSerializer, status: :created
    else
      render json: { errors: @event.errors }, status: :unprocessable_entity
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      render json: @event, serializer: EventSerializer
    else
      render json: { errors: @event.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find_by!(service_id: params[:id])
    @event.destroy
    head :no_content
  end

  private

  def event_params
    params.require(:event).permit(:id, :date_program, :duration)
  end
end
