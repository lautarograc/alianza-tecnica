class EventSerializer
  include JSONAPI::Serializer
  attributes :starts, :ends, :service_id, :type_is
end
