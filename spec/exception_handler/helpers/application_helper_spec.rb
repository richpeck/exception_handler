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

# Should reside in spec/module/helpers
# Testing specific helpers (in this case ApplicationHelper)
# Refs...
# http://stackoverflow.com/a/12846630/1143732
# https://github.com/rspec/rspec-rails#helper-specs

#####################################################

# Needs the RSpec helper / config 
require "spec_helper"

####

module ExceptionHandler
  describe ApplicationHelper, type: :helper do 

    # Defs
    let (:page) { ErrorPage.new exception, { "PATH_INFO" => "/some/path" } }

    #####################################################

    # "app" method
    it "displays parent Rails app name" do

    end
  end
end

#####################################################
#####################################################