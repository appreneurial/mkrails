@recipes = ENV["MKRAILS_RECIPES"].split(",")
@source = ENV["MKRAILS_SOURCE"]

def get_from_source(source_path, destination_path = nil)
	destination_path ||= source_path
	source_path = "#{@source}/#{source_path}"

	if source_path.start_with?("http://", "https://")
		get source_path, destination_path
	else
		copy_file source_path, destination_path
	end
end

def apply_manifests
	temp_dir = Dir.pwd + "/tmp/mkrails"
	additions = []
	removals = []

	@recipes.each do |recipe|
		manifest_path = "#{temp_dir}/#{recipe}.manifest"
		get_from_source "recipes/#{recipe}/manifest", manifest_path
		File.foreach(manifest_path) do |manifest_line|
			manifest_line_details = manifest_line.strip.split(" ", 2)
			manifest_line_action = manifest_line_details[0]
			manifest_line_filename = manifest_line_details[1]
			case manifest_line_action
			when "+"
				additions << manifest_line_filename unless additions.include?(manifest_line_filename)
			when "-"
				removals << manifest_line_filename unless removals.include?(manifest_line_filename)
			end
		end
	end

	removals.sort.each do |removal|
		remove_file removal
	end

	additions.sort.each do |addition|
		addition_path = "#{temp_dir}/#{addition}"
		get_from_source addition, addition_path
		template addition_path, addition, force: true
	end

	remove_dir temp_dir
end

def apply_recipes(stage)
	@recipes.each do |recipe|
		apply "#{@source}/recipes/#{recipe}/#{stage}.rb"
	end
end

apply_recipes("gems")

run "bundle install"
run "rake db:create db:migrate"

apply_recipes("initialize")

apply_manifests

apply_recipes("finalize")

def run_bundle; end