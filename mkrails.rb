@recipes = ENV["MKRAILS_RECIPES"].split(",")
@source = ENV["MKRAILS_SOURCE"]

def apply_recipes(stage)
	@recipes.each do |recipe|
		apply "#{@source}/recipes/#{recipe}/#{stage}.rb"
	end
end

apply_recipes("gems")

run "bundle install"
run "rake db:create db:migrate"

apply_recipes("initialize")

def run_bundle; end