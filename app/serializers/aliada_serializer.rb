# frozen_string_literal: true

class AliadaSerializer
  include JSONAPI::Serializer
  attribute :name
  attribute :calendar, if: proc { |_record, params| params[:include_calendar] }
end
