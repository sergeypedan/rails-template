# frozen_string_literal: true

module TimeHelper

  # 3.0 -> "+03:00"
  def numeric_to_timezone_offset(value)
    return ("+0%.2f" % value).sub('.', ':') if (0...10).cover? value
    return ( "+%.2f" % value).sub('.', ':') if (10..12).cover? value
    return (  "%.2f" % value).sub('.', ':') if (-12..-10).cover? value
    return (  "%.2f" % value).insert(1, "0").sub('.', ':')
  end


  def humanize_timespan(time)
    return time if time.to_i < 10 # Maybe time has literal value, like "01:00", which can convert into 1
    hours, minutes = time.to_i.divmod(60) # will return [1, 30] for 90
    "#{hours}:#{minutes}"
  end

end
