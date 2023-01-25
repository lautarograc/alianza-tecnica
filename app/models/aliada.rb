class Aliada < ApplicationRecord
  include Assignable
  has_many :events, dependent: :destroy

  def assign_event(event)
    pair_event = set_pair_event(event)
    puts "pair_event: #{pair_event.inspect}"
    if can_assign?(event, self) && can_assign?(pair_event, self)
      assign_to(event, self)
      assign_to(pair_event, self)
    end
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
