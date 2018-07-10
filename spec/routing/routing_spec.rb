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
RSpec.describe 'ExceptionHandler::Engine.routes' do

    # => Let (config)
    let(:dev) { ExceptionHandler.config.dev }

  #############################################
  #############################################

    # => Before (set routes)
    before(:each) { Rails.application.reload_routes! }

  #############################################
  #############################################

  # => Rails application Routes
  # => Should be routable WITH dev option
  # => Should not be routable WITHOUT dev option
  context "Rails.application.routes" do

    # => Routes
    routes { Rails.application.routes }

    # => Dev mode
    context "dev mode" do
      subject { dev }
      before { ExceptionHandler.config.dev = true }
      before { Rails.application.reload_routes! }

      it {should eq(true) }
      it "has exception routes" do
        Rack::Utils::SYMBOL_TO_STATUS_CODE.select{ |key, value| value.to_s.match('\b(?:4[0-9]{2}|5[0-9]{2}|599)\b') }.each do |status,code|
          expect(:get => code.to_s).to route_to(:controller => "exception_handler/exceptions", :action => "show", :code => status.to_sym)
        end
      end
    end

    # => Not dev mode
    context "!dev mode" do
      subject { dev }
      before { ExceptionHandler.config.dev = false }

      it { should_not eq(true) }
      it "does not have exception routes" do
        Rack::Utils::SYMBOL_TO_STATUS_CODE.select{ |key, value| value.to_s.match('\b(?:4[0-9]{2}|5[0-9]{2}|599)\b') }.each do |status,code|
          expect(:get => code.to_s).not_to be_routable
        end
      end
    end

  end

  #############################################
  #############################################

  # => Engine based Routes
  # => Should not be routable (at all)
  # => Test with + without dev option
  context "ExceptionHandler::Engine.routes" do

    # => Routes
    routes { ExceptionHandler::Engine.routes }

    # => Dev mode
    context "dev mode" do
      subject { dev }
      before { ExceptionHandler.config.dev = true }

      it {should eq(true) }
      it "does not have exception routes" do
        Rack::Utils::SYMBOL_TO_STATUS_CODE.select{ |key, value| value.to_s.match('\b(?:4[0-9]{2}|5[0-9]{2}|599)\b') }.each do |status,code|
          expect(:get => code.to_s).not_to be_routable
        end
      end
    end

    # => Not dev mode
    context "!dev mode" do
      subject { dev }
      before { ExceptionHandler.config.dev = false }

      it { should_not eq(true) }
      it "does not have exception routes" do
        Rack::Utils::SYMBOL_TO_STATUS_CODE.select{ |key, value| value.to_s.match('\b(?:4[0-9]{2}|5[0-9]{2}|599)\b') }.each do |status,code|
          expect(:get => code.to_s).not_to be_routable
        end
      end
    end
  end

  #############################################
  #############################################

end

###############################################
###############################################
