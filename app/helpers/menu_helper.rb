# frozen_string_literal: true

module MenuHelper

	# https://gist.github.com/dcyoung-dev/072a27bc96de52abf2dc3c21a969b89a
	def active_link_to(name = nil, options = nil, **html_options, &block)
		options = block_given? ? name : options

		if current_page?(options)
			html_options[:class] = class_names(html_options[:class], :active)
			html_options[:aria] = html_options.fetch(:aria, {}).merge(current: :page)
		end

		if block_given?
			link_to options, html_options, &block
		else
			link_to name, options, html_options
		end
	end

end
