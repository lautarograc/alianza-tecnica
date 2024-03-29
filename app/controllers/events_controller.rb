# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    @events = Event.all
    render json: @events, each_serializer: EventSerializer
  end

  def show
    @event = Event.find_by!(service_id: params[:id])
    render json: EventSerializer.new(@event)
  end

  def create
    @event = Event.new
    @event.starts = event_params.fetch(:date_program)
    @event.ends = @event.starts + event_params.fetch(:duration).to_i.hours
    @event.service_id = event_params.fetch(:id)
    @names = event_params[:names] || []
    if @event.save
      @travel_event = Event.new(starts: @event.starts - 1.hour, ends: @event.starts - 1.minute,
                                service_id: @event.service_id, type_is: 'travel')
      @travel_event.save!
      AliadaAssignationWorker.perform_async(@event.id, @names)
      render json: EventSerializer.new(@event), status: :created
    else
      render json: { errors: @event.errors }, status: :unprocessable_entity
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      render json: EventSerializer.new(@event), status: :ok
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
    params.require(:event).permit(:id, :date_program, :duration, :names)
  end
end
