module ExceptionHandler
	class ConfigGenerator < Rails::Generators::Base
		source_root File.expand_path("../../templates", __FILE__) #Needed to reference files

		def create_initializer_file
			template "exception_handler.rb", "config/initializers/exception_handler.rb" # https://github.com/plataformatec/devise/blob/master/lib/generators/devise/install_generator.rb#L13
		end
	end
end