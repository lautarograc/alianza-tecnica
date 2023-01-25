class AliadaAssignationWorker
  include Sidekiq::Worker

  def perform(event_id, names)
    event = Event.find(event_id)
    if names.empty?
      aliadas = Aliada.all
    else
      aliadas = names.map { |name| Aliada.find_by!(name: name) }
    end
    aliadas.each do |aliada|
      if aliada.assign_event(event)
        break
      end
    end
  end
end
