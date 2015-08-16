module ExceptionHandler
	class Generators
		class InstallGenerator < Rails::Generators::Base

			#Needed to reference files
			source_root File.expand_path("../../templates", __FILE__) 

			###########################################

			#Config
			def create_config_file
				return unless options.empty?
				template "config.rb", "config/initializers/exception_handler.rb" # https://github.com/plataformatec/devise/blob/master/lib/generators/devise/install_generator.rb#L13
			end

			###########################################

		end
	end
end