module ExceptionHandler
	class InstallGenerator < Rails::Generators::Base
		def create_initializer_file
			create_file "config/initializers/exception_handler.rb", "# Add initialization content here"
		end
	end
end