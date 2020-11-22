# frozen_string_literal: true

module DateTimeHelper

  def ends_tonight_or_next_morning?(start_time, end_time)
    return unless [start_time, end_time].all?(&:acts_like_time?)
    return true if  end_time.day == start_time.day
    return true if (end_time.day == start_time.day + 1) && (end_time.hour < 8)
    return false
  end

  # 3.0 -> "+03:00"
  def timezone_offset_iso(hours)
    validate_argument_type! hours, [Integer, Float]
    ActiveSupport::TimeZone.seconds_to_utc_offset(hours.hours, true)
  end

end
