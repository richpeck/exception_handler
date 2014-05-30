module ExceptionHandler
	class InstallGenerator < Rails::Generators::Base

		#Needed to reference files
		source_root File.expand_path("../../templates", __FILE__) 

		#Option
		class_option :config, type: :boolean, desc: 'Add initializer to /config/initializers, to help define config options'
		class_option :assets, desc: 'Add views, controllers, models & assets to app (for customization)'
		class_option :migration, type: :boolean, desc: 'Create migration'
				
		#Config
		def create_config_file
			return unless options.config? || options.empty?
			template "exception_handler.rb", "config/initializers/exception_handler.rb" # https://github.com/plataformatec/devise/blob/master/lib/generators/devise/install_generator.rb#L13
		end

		#Assets
		def create_customization assets = options.assets
 			#(views / controllers / models / assets)
 			return unless assets || options.empty?
	 		file_generator assets
		end

		#Migration
		def create_migration
			return unless options.migration? || options.empty?
			template "create_table.rb", "db/migrate/create_table.rb" #-> Need to use ActiveRecord::Generators::Base
		end

		protected

		#File Generator
		def file_generator args = options, options = %w(views controllers models assets)

			#Valid?
			return raise "Invalid Argument" unless options.include? args

			#Types
			if args.is_a? String
				create_file "config/initializers/#{args}.rb", "# Add initialization content here"
			elsif args.is_a? Array
				for arg in args do
					create_file "config/initializers/#{arg}.rb", "# Add initialization content here" #Need to use template
				end
			else
				raise "Sorry, you either need to use 'views', 'controllers', 'models', 'assets' as the --files options"
			end

		end
	end
end