module Assignable
  extend ActiveSupport::Concern

  included do
    scope :in_range, ->(range) { where("starts <= ? AND ends >= ?", range.end, range.begin) }
  end

  def assign_to(object, aliada)
    object.aliada = aliada
    object.save
  end

  def can_assign?(object, aliada)
    validate_overlapping_events(object.starts, object.ends, aliada)
  end

  def assigned_to?(object)
    object.aliada.present?
  end

  def unassign_from(object)
    object.aliada = nil
    object.save
  end

  # validate that starts and ends don't overlap with other events assigned to the same aliada
  def validate_overlapping_events(starts, ends, aliada)
    range = starts..ends
    overlaps = aliada.events.in_range(range)
    if overlaps.present?
      errors.add(:base, "Aliada is already assigned to an event in this time range")
      return false
    else
      return true
    end
  end

  def set_pair_event(object)
    @pair_event = Event.where.not(id: object.id).find_by!(service_id: object.service_id)
  end
end
