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

		#Create Migration
		def create_errors_migration
			migration_template "create_table.rb", "db/migrate/create_errors.rb"
		end

	end
end