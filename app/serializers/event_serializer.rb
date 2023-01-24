class EventSerializer
  include JSONAPI::Serializer
  attributes :start, :end, :service_id, :type
end
