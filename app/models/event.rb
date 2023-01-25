# frozen_string_literal: true

class Event < ApplicationRecord
  include Assignable
  belongs_to :aliada, optional: true
end
