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
end
