###########################################

require 'rails/generators/active_record'

###########################################

#Migration Generator (for adding errors table)
#Ref: https://github.com/plataformatec/devise/blob/master/lib/generators/active_record/devise_generator.rb

module ExceptionHandler
  class MigrationGenerator < ActiveRecord::Generators::Base
  
  		#Name - from http://old.thoughtsincomputation.com/posts/cgfr3-part-3-adding-a-generator
  		argument :name, default: "migration"

		#Source of Migrations
		source_root File.expand_path("../../templates", __FILE__)

		###########################################

		#Table Name - false = off, true = errors, value = value
		#Always outputs string for some reason...
		def table_name
    		ExceptionHandler.config.db || :errors
		end

		###########################################

		#Create
		def create_errors_migration
			migration_template "migration.rb.erb", "db/migrate/create_errors.rb"
		end

		###########################################

	end
end