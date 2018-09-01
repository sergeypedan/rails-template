module DateTagHelper

  def time_tag(datetime, format="%-d %B %Y", classes="")
    return if datetime.blank?
    content_tag :time, l(datetime, format: format), datetime: datetime.strftime("%F"), class: classes
  end

end
