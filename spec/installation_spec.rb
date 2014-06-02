###########################################

require 'spec_helper'

###########################################

class InstallerSpec < Rails::Generators::TestCase

	#Setup
	tests ExceptionHandler::Generators::InstallGenerator
	destination File.expand_path("../../tmp", __FILE__)

	#Config Installer
	test "Assert Config Files Are Created" do 
		run_generator
    assert_file "config/initializers/exception_handler.rb"
	end

end