class AliadaAssignationWorker
  include Sidekiq::Worker

  def perform(event_id, names)
    event = Event.find(event_id)
    unless names.empty?
      aliadas = names.map { |name| Aliada.find_by!(name: name) }
    else
      aliadas = Aliada.all
    end
    aliadas.each do |aliada|
      if aliada.assign_event(event)
        break
      end
    end
  end
end
