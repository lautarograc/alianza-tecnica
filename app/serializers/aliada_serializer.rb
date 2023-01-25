class AliadaSerializer
  include JSONAPI::Serializer
  attribute :name
  attribute :calendar, if: Proc.new { |record, params| params[:include_calendar] }
end
