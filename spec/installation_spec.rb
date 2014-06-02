###########################################

require 'spec_helper'
require "generators/exception_handler/install_generator"

###########################################

class InstallerSpec < Rails::Generators::TestCase
	tests ExceptionHandler::Generators::InstallGenerator
	destination File.expand_path("../../tmp", __FILE__)

	#Config Installer
	test "should add config initializer" do 
		run_generator %w(install)
		File.exist?("config/intializers/exception_handler.rb").should be_true
	end

end