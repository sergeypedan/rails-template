# frozen_string_literal: true

module MarkDownHandler

	def self.erb_handler
		@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
	end

	def self.markdown_renderer
		@markdown_renderer ||= Redcarpet::Markdown.new(Redcarpet::Renderer::HTML, autolink: true, tables: true)
	end

	def self.call(template, source)
		erb_html = markdown_renderer.render(source)
		erb_handler.call(template, CGI.unescapeHTML(erb_html))
	end

end

ActionView::Template.register_template_handler :md, MarkDownHandler
