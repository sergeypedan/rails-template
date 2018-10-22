# require Rails.root.join('lib/typography/corrector')

module MarkDownHelper

  def proofread(text)
    Typography::Corrector.proofread(text)
  end

  def markdown(text)
    return unless text
    text = Typography::Corrector.proofread(text)
    options = [auto_ids: true]
    Kramdown::Document.new(text, *options).to_html.html_safe
  end

end
