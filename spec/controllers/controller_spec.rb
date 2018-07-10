#####################################################
#####################################################
##  _____             _             _ _            ##
## /  __ \           | |           | | |           ##
## | /  \/ ___  _ __ | |_ _ __ ___ | | | ___ _ __  ##
## | |    / _ \| '_ \| __| '__/ _ \| | |/ _ \ '__| ##
## | \__/\ (_) | | | | |_| | | (_) | | |  __/ |    ##
##  \____/\___/|_| |_|\__|_|  \___/|_|_|\___|_|    ##
##                                                 ##
#####################################################
#####################################################

require 'spec_helper'

###############################################
###############################################

# => ExceptionHandler (Controller)
# => Test erroneous requests under different circumstances
# => Expect the return of 404, 500 (etc) Error Pages
# => Test layout, show action, @exception object and different config options
RSpec.describe ExceptionHandler::ExceptionsController do

  # => General
  # => Used to describe the actual Controller class
  describe "class" do
    subject { controller }
    it { should respond_to :show }
  end

  # => Layout
  # => Expected results & overall views
  describe "layout" do
    #subject { response.layout }
    #it { should be_a String }
  end

  # => Response
  # => Should deliver 404 / 500 error responses
  # => Should deliver appropriate headers, layout etc
  describe "response" do

    # => Before
    before(:each) { }

    # => 404
    context "404" do
      subject { response }
      it { should have_http_status :ok }

    end

    # => 500
    context "500" do
    end

  end

end

###############################################
###############################################
