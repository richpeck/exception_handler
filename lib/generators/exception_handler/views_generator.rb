module ExceptionHandler
	class ViewsGenerator < Rails::Generators::Base

		#Views
		@@views = %w(views controllers models assets)

		#Options
		class_option :files, default: @@views, desc: "Select file types (views, models, controllers, assets)"

		#Needed to reference files
		source_root File.expand_path("../../../../app", __FILE__) 

		###########################################

		#Files
		def create_files
			generate_files options.files
		end

		###########################################

		protected

		#File Generator
		def generate_files args

			#Valid?
			return raise args.inspect unless @@views.include? args

			#Types
			if args.is_a? String
				directory args, "app/#{args}"
			elsif args.is_a? Array
				for arg in args do
					directory arg, "app/#{arg}"
				end
			end

			#Success
			puts "Files transferred successfully"
		end

		###########################################

	end
end