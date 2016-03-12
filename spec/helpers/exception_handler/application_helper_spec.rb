#####################################################
##         _   _      _                            ##
##        | | | |    | |                           ##
##        | |_| | ___| |_ __   ___ _ __ ___        ##
##        |  _  |/ _ \ | '_ \ / _ \ '__/ __|       ##
##        | | | |  __/ | |_) |  __/ |  \__ \       ##
##        \_| |_/\___|_| .__/ \___|_|  |___/       ##
##                   | |                           ##
##                   |_|                           ##
#####################################################

# Should reside in spec/**module**/helpers
# Testing specific helpers (in this case ApplicationHelper)
# Refs...
# http://stackoverflow.com/a/12846630/1143732
# https://github.com/rspec/rspec-rails#helper-specs

#####################################################

# Needs the RSpec helper / config 
require 'spec_helper'

####

module ExceptionHandler
  describe "ApplicationHelper", type: :helper do 

    # Defs
    #let (:page) { ErrorPage.new exception, { "PATH_INFO" => "/some/path" } }

    #####################################################

    # "app" method
    # https://www.relishapp.com/rspec/rspec-rails/v/2-0/docs/helper-specs/helper-spec
    it "displays parent Rails app name" do
      helper.app.should eql(Rails.application.class.parent_name)
    end
  end
end

#####################################################
#####################################################