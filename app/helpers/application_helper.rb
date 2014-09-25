module ApplicationHelper
	def set_title(*title_parts)
		content_for(:title, title_parts.join(": ")) if title_parts.any?
	end

	def set_subtitle(subtitle)
		content_for(:subtitle, subtitle) unless subtitle.blank?
	end

	def set_description(description)
		content_for(:description, description) unless description.blank?
	end

	def set_author(author)
		content_for(:author, author) unless author.blank?
	end

	def set_publisher(publisher)
		content_for(:publisher, publisher) unless publisher.blank?
	end

	def set_social_tags(options = {})
		content_for(:social_title, options[:title]) if options[:title]
		content_for(:social_description, options[:description]) if options[:description]
		content_for(:social_image, options[:image]) if options[:image]
		content_for(:social_url, options[:url]) if options[:url]
		content_for(:og_type, options[:og_type]) if options[:og_type]
		content_for(:twitter_card, options[:twitter_card]) if options[:twitter_card]
	end
end
