###########################################

require 'spec_helper'

###########################################

class InstallationSpec < Rails::Generators::TestCase

	#Setup
	tests ExceptionHandler::InstallGenerator
	destination File.expand_path("../../tmp", __FILE__)

	#Before
	before(:all) do
		prepare_destination
		run_generator
	end

	#Config Installer
	test "Assert Config Files Are Created" do 
		assert_file "config/initializers/exception_handler.rb"
	end

end