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

	def bootstrap_nav(options = {}, &block)
		ul_classes = ["nav"]
		ul_classes << "nav-tabs" if options[:tabs] == true
		ul_classes << "nav-pills" if options[:pills] == true
		ul_classes << "nav-stacked" if options[:stacked] == true
		ul_classes << "nav-justified" if options[:justified] == true
		ul_classes << "navbar-nav" if options[:navbar] == true
		ul_classes << (options[:navbar] == true ? "navbar-#{options[:pull].to_s}" : "pull-#{options[:pull].to_s}") if options[:pull]

		content_tag("ul", nil, class: ul_classes.join(" ")) do
			capture(&block) if block_given?
		end
	end

	def bootstrap_nav_link(text, destination, options = {})
		li_classes = []
		li_classes << "active" if options.delete(:active) == true
		li_classes << "disabled" if options.delete(:disabled) == true

		content_tag("li", link_to(text, destination, options), class: li_classes.join(" "))
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

	def bootstrap_page_header(&block)
		content_tag("div", nil, class: "page-header") do
			capture(&block) if block_given?
		end
	end

	def bootstrap_row(&block)
		content_tag("div", nil, class: "row") do
			capture(&block) if block_given?
		end
	end

	def bootstrap_column(options = {}, &block)
		div_classes = []
		options[:size].each do |key, value|
			div_classes << "col-#{key.to_s}-#{value}"
		end if options[:size]
		options[:offset].each do |key, value|
			div_classes << "col-#{key.to_s}-offset-#{value}"
		end if options[:offset]
		options[:push].each do |key, value|
			div_classes << "col-#{key.to_s}-push-#{value}"
		end if options[:push]
		options[:pull].each do |key, value|
			div_classes << "col-#{key.to_s}-pull-#{value}"
		end if options[:pull]
		div_classes << options[:class] if options[:class]

		content_tag("div", nil, class: div_classes.join(" ")) do
			capture(&block) if block_given?
		end
	end

	def bootstrap_table(options = {}, &block)
		table_classes = ["table"]
		table_classes << "table-striped" if options[:striped] == true
		table_classes << "table-bordered" if options[:bordered] == true
		table_classes << "table-hover" if options[:hover] == true
		table_classes << "table-condensed" if options[:condensed] == true

		content_tag("div", nil, class: "table-responsive") do
			content_tag("table", nil, class: table_classes.join(" ")) do
				capture(&block) if block_given?
			end
		end
	end

	# Deprecated Functions

	def bootstrap_navbar_nav(options = {}, &block)
		options << {navbar: true}
		bootstrap_nav(options) do
			capture(&block) if block_given?
		end
	end
end
