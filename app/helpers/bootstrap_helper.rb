module BootstrapHelper
	def bootstrap_alert(type, content, options = {}, &block)
		classes = ["alert", "alert-#{["danger", "info", "success", "warning"].include?(type.to_s) ? type.to_s : "info"}"]
		classes << "alert-dismissible" if options[:dismissible] == true

		content_tag("div", nil, class: classes.join(" "), role: "alert") do
			(content_tag("button", nil, class: "close", data: {dismiss: "alert"}) do
				content_tag("span", raw("&times;"), "aria-hidden" => "true") +
				content_tag("span", "Close", class: "sr-only")
			end if options[:dismissible] == true) +
			(content || (capture(&block) if block_given?))
		end
	end

	def bootstrap_flash(options = {})
		alerts = []

		flash.each do |key, value|
			type = case key.to_s
			when "alert"
				"danger"
			when "notice"
				"success"
			else
				key.to_s
			end
			alerts << bootstrap_alert(type, value, options)
		end

		alerts.join("\n").html_safe
	end

	def bootstrap_navbar(options = {}, &block)
		nav_classes = ["navbar"]
		nav_classes << (options[:inverse] == true ? "navbar-inverse" : "navbar-default")
		nav_classes << "navbar-fixed-#{options[:fixed].to_s}" if options[:fixed]
		nav_classes << "navbar-static-#{options[:static].to_s}" if options[:static]

		content_tag("nav", nil, class: nav_classes.join(" "), role: "navigation") do
			content_tag("div", nil, class: options[:fluid] == true ? "container-fluid" : "container") do
				content_tag("div", nil, class: "navbar-header") do
					content_tag("button", nil, class: "navbar-toggle collapsed", data: {toggle: "collapse", target: "#bootstrap_navbar"}) do
						content_tag("span", "Toggle Navigation", class: "sr-only") +
						content_tag("span", nil, class: "icon-bar") +
						content_tag("span", nil, class: "icon-bar") +
						content_tag("span", nil, class: "icon-bar")
					end +
					(link_to(options[:brand], root_url, class: "navbar-brand") unless options[:brand].nil?)
				end +
				content_tag("div", nil, class: "collapse navbar-collapse", id: "bootstrap_navbar") do
					capture(&block) if block_given?
				end
			end
		end
	end

	def bootstrap_navbar_nav(options = {}, &block)
		ul_classes = ["nav", "navbar-nav"]
		ul_classes << "navbar-#{options[:pull].to_s}" if options[:pull]

		content_tag("ul", nil, class: ul_classes.join(" ")) do
			capture(&block) if block_given?
		end
	end

	def bootstrap_nav_link(text, destination, options = {})
		li_classes = []
		li_classes << "active" if options.delete(:active) == true

		content_tag("li", link_to(text, destination, options), class: li_classes.join(" "))
	end
end
