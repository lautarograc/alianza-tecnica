class TravelEventJob
  include Sidekiq::Worker

  def perform(event_id)
    event = Event.find(event_id)
    travel_event = Event.new(type_is: "travel", starts: event.starts - 1.hour, ends: event.starts, service_id: event.service_id)
    travel_event.save
  end
end
