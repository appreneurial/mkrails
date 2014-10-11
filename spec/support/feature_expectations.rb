module FeatureExpectations
	def expect_button(locator, options = {})
		expect(page).to have_button(locator, options)
	end

	def expect_no_button(locator, options = {})
		expect(page).to_not have_button(locator, options)
	end

	def expect_checked_field(locator, options = {})
		expect(page).to have_checked_field(locator, options)
	end

	def expect_no_checked_field(locator, options = {})
		expect(page).to_not have_checked_field(locator, options)
	end

	def expect_content(*args)
		expect(page).to have_content(args)
	end

	def expect_no_content(*args)
		expect(page).to_not have_content(args)
	end

	def expect_css(css, options = {})
		expect(page).to have_css(css, options)
	end

	def expect_no_css(css, options = {})
		expect(page).to_not have_css(css, options)
	end

	def expect_error_messages(options = {})
		expect_content("Please review the problems below")

		options[:absence].each do |field|
			expect_content("#{field}must be blank")
		end if options[:absence]

		options[:accepted].each do |field|
			expect_content("#{field}must be accepted")
		end if options[:accepted]

		options[:confirmed].each do |field|
			expect_content("#{field}doesn't match confirmation")
		end if options[:confirmed]

		options[:excluded].each do |field|
			expect_content("#{field}is reserved")
		end if options[:excluded]

		options[:format].each do |field|
			expect_content("#{field}is invalid")
		end if options[:format]

		options[:included].each do |field|
			expect_content("#{field}is not included in the list")
		end if options[:included]

		options[:long].each do |field|
			expect_content("#{field}must have at most")
		end if options[:long]

		options[:numerical].each do |field|
			expect_content("#{field}is not a number")
		end if options[:numerical]

		options[:optional].each do |field|
			expect_no_content("#{field}can't be blank")
		end if options[:optional]

		options[:required].each do |field|
			expect_content("#{field}can't be blank")
		end if options[:required]

		options[:short].each do |field|
			expect_content("#{field}must have at least")
		end if options[:short]

		options[:unique].each do |field|
			expect_content("#{field}has already been taken")
		end if options[:unique]
	end

	def expect_field(locator, options = {})
		expect(page).to have_field(locator, options)
	end

	def expect_no_field(locator, options = {})
		expect(page).to_not have_field(locator, options)
	end

	def expect_link(locator, options = {})
		expect(page).to have_link(selector, options)
	end

	def expect_no_link(locator, options = {})
		expect(page).to_not have_link(selector, options)
	end

	def expect_meta_tag(options = {})
		css = "meta"
		options.each do |property, value|
			css += "[#{property}='#{value}']"
		end

		expect_css(css, visible: false)
	end

	def expect_no_meta_tag(options = {})
		css = "meta"
		options.each do |property, value|
			css += "[#{property}='#{value}']"
		end

		expect_no_css(css, visible: false)
	end

	def expect_path(path)
		expect(page.current_url).to have_content(path)
	end

	def expect_no_path(path)
		expect(page.current_url).to_not have_content(path)
	end

	def expect_select(locator, options = {})
		expect(page).to have_select(locator, options)
	end

	def expect_no_select(locator, options = {})
		expect(page).to_not have_select(locator, options)
	end

	def expect_selector(*args)
		expect(page).to have_selector(args)
	end

	def expect_no_selector(*args)
		expect(page).to_not have_selector(args)
	end

	def expect_table(locator, options = {})
		expect(page).to have_table(locator, options)
	end

	def expect_no_table(locator, options = {})
		expect(page).to_not have_table(locator, options)
	end

	def expect_text(*args)
		expect(page).to have_text(args)
	end

	def expect_no_text(*args)
		expect(page).to_not have_text(args)
	end

	def expect_title(title, options = {})
		expect(page).to have_title(title, options)
	end

	def expect_no_title(title, options = {})
		expect(page).to_not have_title(title, options)
	end

	def expect_unchecked_field(locator, options = {})
		expect(page).to have_unchecked_field(locator, options)
	end

	def expect_no_unchecked_field(locator, options = {})
		expect(page).to_not have_unchecked_field(locator, options)
	end

	def expect_url(url)
		expect(page.current_url).to eq(url)
	end

	def expect_no_url(url)
		expect(page.current_url).to_not eq(url)
	end

	def expect_xpath(xpath, options = {})
		expect(page).to have_xpath(xpath, options)
	end

	def expect_no_xpath(xpath, options = {})
		expect(page).to_not have_xpath(xpath, options)
	end
end

RSpec.configure do |c|
	c.include FeatureExpectations, type: :feature
end