gsub_file "Gemfile", "# gem 'unicorn'", "gem 'unicorn'"
inject_into_file "Gemfile", after: "gem 'unicorn'\n" do
	"gem 'foreman', group: :development\n"
end