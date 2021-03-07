# require Rails.root.join('lib/typography/corrector')

module MarkDownHelper

	def proofread(text)
		Typography::Corrector.proofread(text)
	end

	def markdown(text, options={})
		return nil if text.blank?
		html = Kramdown::Document.new(proofread(text), auto_ids: true).to_html.html_safe
		return html if options.empty?
		tag.div html, options
	end

end
