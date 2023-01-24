class Event < ApplicationRecord
  include Assignable
  belongs_to :aliada, optional: true
end
