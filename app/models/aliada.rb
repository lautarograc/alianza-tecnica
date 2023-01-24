class Aliada < ApplicationRecord
  include Assignable
  has_many :events, dependent: :destroy

  def assign_event(event)
    assign_to(object = event, aliada = self)
  end

  def unassign_event(event)
    unassign_from(object = event)
  end
end
