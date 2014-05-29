module ExceptionHandler
	class InstallGenerator < Rails::Generators::Base

		#Needed to reference files
		source_root File.expand_path("../../templates", __FILE__) 

		#Option
		class_option :config, type: :boolean, desc: 'Add initializer to /config/initializers, to help define config options'
		class_option :files, desc: 'Add views, controllers, models & assets to app (for customization)'
		class_option :migration, type: :boolean, desc: 'Create migration'

		#Config
		def create_config_file
			return unless options.config? || options.empty?
			template "exception_handler.rb", "config/initializers/exception_handler.rb" # https://github.com/plataformatec/devise/blob/master/lib/generators/devise/install_generator.rb#L13
		end

		#Assets
		def create_customization
 			#(views / controllers / models / assets)
 			return unless options.files? || options.empty?
 			file_generator options.files
		end

		#Migration
		def create_migration
			return unless options.migration? || options.empty?
			template "create_table.rb", "db/migrate/create_table.rb" #-> Need to use ActiveRecord::Generators::Base
		end

		protected

		#File Generator
		def file_generator args = %w(views controllers models assets)
			if args.is_a? String
				create_file "config/initializers/#{args}.rb", "# Add initialization content here"
			else
				for arg in args do
					create_file "config/initializers/#{arg}.rb", "# Add initialization content here"
				end
			end
		end
	end
end