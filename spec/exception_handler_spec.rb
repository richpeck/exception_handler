###############################################
###############################################
##       _____  _____                        ##
##      | ___ \/  ___|                       ##
##      | |_/ /\ `--. _ __   ___  ___        ##
##      |    /  `--. \ '_ \ / _ \/ __|       ##
##      | |\ \ /\__/ / |_) |  __/ (__        ##
##      \_| \_|\____/| .__/ \___|\___|       ##
##                   | |                     ##
##                   |_|                     ##
###############################################
###############################################

require 'spec_helper'

###############################################
###############################################

# => ExceptionHandler (base)
RSpec.describe ExceptionHandler do

  #############################################
  #############################################

    # => Default
    # => Version needs to be present
    it "has a version number" do
      expect(ExceptionHandler::VERSION::STRING).not_to be nil
    end

    # => Present version
    it "is version 0.8.0.0" do
      expect(ExceptionHandler::VERSION::STRING).to eq '0.8.0.0'
    end

  #############################################
  #############################################

    # => Config
    # => This needs to be an instance of a class
    #it "has initialized config options" do
    #  expect(ExceptionHandler.config).to eq ExceptionHandler::Config.new
    #end

    # => Middleware
    # => Check if it's correctly overwritten @exceptions_app
    # => http://guides.rubyonrails.org/configuring.html#rails-general-configuration
    #it "has overwritten @exceptions_app hook" do
    #  expect(Rails.application.config.exceptions_app).to eq "2"
    #end

    # => Dev Mode
    # => Changes "consider_all_requests_local" to opposite of config
    it "has dev mode" do
      expect(Rails.application.config.consider_all_requests_local).not_to be ExceptionHandler.config.dev
    end

  #############################################
  #############################################

    # => Routes
    # => Dev mode adds routes for 4xx+5xx
    #it "adds dev routes" do
    #  let {:routes}
    #end

  #############################################
  #############################################

end

###############################################
###############################################
