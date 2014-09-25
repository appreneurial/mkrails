inject_into_file "Gemfile", after: "source 'https://rubygems.org'\n" do
	"ruby '#{ENV["MKRAILS_RUBY_VERSION"]}'"
end
gem 'rails_12factor', group: :production