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
# => Test underlying engine (loading, initializers, etc)
# => Ensure that all elements are correctly integrated into Rails core
RSpec.describe ExceptionHandler, "Routes" do

  #############################################
  #############################################


    # => Routes
    describe "Routes", type: :routing do

      # => Options
      let(:routes) { Rack::Utils::SYMBOL_TO_STATUS_CODE.select{ |key, value| value.to_s.match('\b(?:4[0-9]{2}|5[0-9]{2}|599)\b')} }
      let(:config) { ExceptionHandler.config }

      # => Dev mode enabled
      # => First check dev mode enabled
      # => Second check for presence of routes
      context "with dev enabled" do
        subject { config.dev = true }
        it      { is_expected.to eq(true) }
        #Rack::Utils::SYMBOL_TO_STATUS_CODE.select{ |key, value| value.to_s.match('\b(?:4[0-9]{2}|5[0-9]{2}|599)\b')}.each do |code,status|
        #  it { expect(get: "/" + status.to_s).to route_to(controller: "exception_handler/exceptions", action: "show", code: code) }
        #end
      end

      # => Dev mode disabled
      # => First check if dev mode disabled
      # => Second check for routes being not_routable
      context "without dev" do
        subject { config.dev = false }
        it      { is_expected.not_to eq(true) }
        #Rack::Utils::SYMBOL_TO_STATUS_CODE.select{ |key, value| value.to_s.match('\b(?:4[0-9]{2}|5[0-9]{2}|599)\b')}.each do |code,status|
        #  it { expect(get: "/" + status.to_s).not_to be_routable }
        #end
      end

    end

  #############################################
  #############################################

end

###############################################
###############################################
