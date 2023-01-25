class Aliada < ApplicationRecord
  include Assignable
  has_many :events, dependent: :destroy

  def assign_event(event)
    assign_to(object = event, aliada = self)
    pair_event = set_pair_event(object)
    assign_to(object = pair_event, aliada = self)
  end

  def unassign_event(event)
    unassign_from(object = event)
    pair_event = set_pair_event(object)
    unassign_from(object = pair_event)
  end

  def calendar
    events = self.events
    events.map do |event|
      {
        start: event.starts,
        end: event.ends,
        type: event.type_is,
        service_id: event.service_id,
      }
    end
  end
end
