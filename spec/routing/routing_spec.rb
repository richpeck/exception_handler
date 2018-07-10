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
# => Test underlying engine (loading, initializers, etc)
# => Ensure that all elements are correctly integrated into Rails core
RSpec.describe ExceptionHandler::ExceptionsController do

  #############################################
  ##############################################
  routes { ExceptionHandler::Engine.routes }

  it "routes to the list of all widgets" do
    expect(:get => '500').to route_to(:controller => "exception_handler/exceptions", :action => "show", :code => :internal_server_error)
  end

  #############################################
  #############################################

end

###############################################
###############################################
