###############################################
###############################################
##       _____            _                  ##
##      | ___ \          | |                 ##
##      | |_/ /___  _   _| |_ ___  ___       ##
##      |    // _ \| | | | __/ _ \/ __|      ##
##      | |\ \ (_) | |_| | ||  __/\__ \      ##
##      \_| \_\___/ \__,_|\__\___||___/      ##
##                                           ##
###############################################
###############################################

require 'spec_helper'

###############################################
###############################################

# => Routes (base)
# => Test underlying routes + engine routes
RSpec.describe 'Routes' do

  #############################################
  ##############################################

  # => Rails application Routes
  # => Should be routable WITH dev option
  # => Should not be routable WITHOUT dev option
  context "app" do
    routes { Rails.application.routes }

    it "routes to the list of all widgets" do
      expect(:get => '500').to route_to(:controller => "exception_handler/exceptions", :action => "show", :code => :internal_server_error)
    end
  end

  # => Engine based Routes
  # => Should not be routable (at all)
  # => Test with + without dev option
  context "engine" do
    routes { ExceptionHandler::Engine.routes }

    it "should not have any routes" do
      expect(:get => '500').not_to be_routable
    end
  end

  #############################################
  #############################################

end

###############################################
###############################################
