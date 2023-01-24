module Assignable
  extend ActiveSupport::Concern

  included do
    scope :in_range, ->(range) { where("starts <= ? AND ends >= ?", range.end, range.begin) }
  end

  def assign_to(object, aliada)
    if validate_overlapping_events(object.starts, object.ends, aliada)
      object.aliada = aliada
      object.save
    end
  end

  def assigned_to?(object)
    object.aliada.present?
  end

  def unassign_from(object)
    object.aliada = nil
    object.save
  end

  private

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
end
