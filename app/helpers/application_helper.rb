module ApplicationHelper
	def set_meta_data(options = {})
		content_for(:meta_title, options[:title]) if options[:title]
		content_for(:meta_description, options[:description]) if options[:description]
		content_for(:meta_author, options[:author]) if options[:author]
		content_for(:meta_publisher, options[:publisher]) if options[:publisher]
	end

	def set_social_tags(options = {})
		content_for(:social_title, options[:title]) if options[:title]
		content_for(:social_description, options[:description]) if options[:description]
		content_for(:social_image, options[:image]) if options[:image]
		content_for(:social_url, options[:url]) if options[:url]
		content_for(:og_type, options[:og_type]) if options[:og_type]
		content_for(:twitter_card, options[:twitter_card]) if options[:twitter_card]
	end

	def set_header_content(options = {}, &buttons)
		content_for(:header_title, options[:title]) if options[:title]
		content_for(:header_subtitle, options[:subtitle]) if options[:subtitle]
		content_for(:header_buttons, capture(&buttons)) if block_given?
	end

	def set_sidebar_content(&content)
		content_for(:sidebar_content, capture(&content)) if block_given?
	end

	def set_main_content(&content)
		content_for(:main_content, capture(&content)) if block_given?
	end

	def checkmark(value)
		value ? fa("check", class: "text-success", fw: true) : fa("times", class: "text-danger", fw: true)
	end

	# Deprecated Methods

	def set_title(*title_parts)
		title = title_parts.join(": ") if title_parts.any?

		set_meta_data(title: title) unless title.blank?
		set_header_content(title: title) unless title.blank?
	end

	def set_subtitle(subtitle)
		set_header_content(subtitle: subtitle) unless subtitle.blank?
	end

	def set_description(description)
		set_meta_data(description: description) unless description.blank?
	end

	def set_author(author)
		set_meta_data(author: author) unless author.blank?
	end

	def set_publisher(publisher)
		set_meta_data(publisher: publisher) unless publisher.blank?
	end

	def sidebar(&content)
		set_sidebar_content do
			capture(&content)
		end
	end

	def content(&content)
		set_main_content do
			capture(&content)
		end
	end
end
