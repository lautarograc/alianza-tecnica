# frozen_string_literal: true

class AliadaAssignationWorker
  include Sidekiq::Worker

  def perform(event_id, names)
    event = Event.find(event_id)
    aliadas = if names.empty?
                Aliada.all
              else
                names.map { |name| Aliada.find_by!(name:) }
              end
    aliadas.each do |aliada|
      break if aliada.assign_event(event)
    end
  end
end
