module FontAwesomeHelper
	def fa(icon, options = {}, &content)
		i_classes = ["fa", "fa-#{icon.to_s}"]
		i_classes << "fa-#{options.delete(:size).to_s}" if options[:size]
		i_classes << "fa-fw" if options.delete(:fw) == true
		i_classes << "fa-li" if options.delete(:li) == true
		i_classes << "fa-border" if options.delete(:border) == true
		i_classes << "fa-spin" if options.delete(:spin) == true
		i_classes << "fa-rotate-#{options.delete(:rotate).to_s}" if options[:rotate]
		i_classes << "fa-flip-#{options.delete(:flip).to_s}" if options[:flip]
		i_classes << "fa-stack-#{options.delete(:stack).to_s}" if options[:stack]
		i_classes << "fa-inverse" if options.delete(:inverse) == true
		i_classes << options.delete(:class) if options[:class]

		content_tag("i", nil, class: i_classes.join(" ")) +
		(capture(&content) if block_given?)
	end

	def fa_ul(options = {}, &content)
		ul_classes = ["fa-ul"]
		ul_classes << options.delete(:class) if options[:class]

		content_tag("ul", nil, class: ul_classes.join(" ")) do
			capture(&content) if block_given?
		end
	end

	def fa_li(icon, options = {}, &content)
		options[:li] = true

		content_tag("li", nil) do
			fa(icon, options) do
				capture(&content) if block_given?
			end
		end
	end

	def fa_stack(options = {}, &content)
		span_classes = ["fa-stack"]
		span_classes << "fa-#{options.delete(:size).to_s}" if options[:size]
		span_classes << options.delete(:class) if options[:class]

		content_tag("span", nil, class: span_classes.join(" ")) do
			capture(&content) if block_given?
		end
	end
end
