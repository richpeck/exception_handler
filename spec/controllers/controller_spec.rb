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

#################################
#################################

  # => Layout
  # => Expected results & overall views
  describe "layout" do
    #subject { response.layout }
    #it { should be_a String }
  end

#################################
#################################

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

#################################
#################################

  # => Dev Routes
  # => Should deliver 404 / 500 error responses
  # => Should deliver appropriate headers, layout etc
  describe "dev routes" do

    # => Item
    before(:context) { ExceptionHandler.config.dev = true }
    before(:context) { Rails.application.reload_routes! }

    # => Items
    let(:dev) { ExceptionHandler.config.dev }

    # => Config

    # => Pages
    # => These are shown when
    context "pages" do

      # => Dev Mode
      # => Only works with dev enabled
      it "has Dev mode enabled" do
        expect(dev).to eq(true)
      end

      # => The error pages need to return the correct status code
      #Rack::Utils::SYMBOL_TO_STATUS_CODE.select{ |key, value| value.to_s.match('\b(?:4[0-9]{2}|5[0-9]{2}|599)\b') }.each do |status,code|
      #  it "shows #{code.to_s} page" do
      #    get :show, params: { code: status.to_sym }
      #    expect(response).to have_http_status status.to_sym
      #    expect(response.body).to match /404/
      #  end
      #end

    end
  end
end

###############################################
###############################################
