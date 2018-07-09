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
RSpec.describe 'ExceptionHandler' do

  #############################################
  #############################################

    # => Ensure Gem has value, loaded etc
    describe "Gem" do

      # => Options
      let(:version) { ExceptionHandler::VERSION::STRING }
      let(:engine)  { ExceptionHandler::Engine }
      let(:config)  { ExceptionHandler.config }

      # => Version needs to exist
      # => Present Version
      describe "version" do
        subject { version }
        it { is_expected.not_to be_empty }
        it { is_expected.to eq('0.8.0.0') }
      end

      # => Loaded?
      # => Accessible by Rails?
      describe "engine" do
        subject { engine }
        it { should be_const_defined(:ExceptionHandler) }
        it { }
      end

    end

  #############################################
  #############################################

    # => Ensure Gem's features are loaded into Rails
    describe "Components" do

      # => Options
      let(:config)          { ExceptionHandler.config }
      let(:dev)             { ExceptionHandler.config.dev }
      let(:middleware)      { Rails.application.config.exceptions_app }
      let(:local_requests)  { Rails.application.config.consider_all_requests_local }

      # => Config
      # => Exists? Accessible? Right Values?
      describe "config" do
        subject { config }
        #it { should be_const_defined(ExceptionHandler::Config) }
      end

      # => Middleware
      # => Check if it's correctly overwritten @exceptions_app
      # => http://guides.rubyonrails.org/configuring.html#rails-general-configuration
      describe "middleware" do
        subject { middleware }
        #it "has overwritten @exceptions_app hook" do
        #  expect().to eq "2"
        #end
      end

      # => Dev Mode
      # => Changes "consider_all_requests_local" to opposite of config
      #it "has dev mode" do
      #  expect(Rails.application.config.consider_all_requests_local).not_to be ExceptionHandler.config.dev
      #end

      # => Custom Exceptions
      # => Ensure custom exceptions added to Rails
      #it "has custom exceptions" do
      #  expect(Rails.application.config.consider_all_requests_local).not_to be ExceptionHandler.config.dev
      #end

    end

  #############################################
  #############################################

    # => Routes
    describe "Routes" do

      # => Options
      let(:routes) { Rack::Utils::SYMBOL_TO_STATUS_CODE.select{ |key, value| value.to_s.match('\b(?:4[0-9]{2}|5[0-9]{2}|599)\b')} }
      let(:dev)    { ExceptionHandler.config.dev }

      # => Dev mode enabled
      # => First check dev mode enabled
      # => Second check for presence of routes
      context "with dev enabled" do
        subject { dev }
        it      { is_expected.not_to eq(true) }
        it      { }
      end

      # => Dev mode disabled
      # => First check if dev mode disabled
      # => Second check for routes being not_routable
      context "without dev" do
        #it { expect(dev).to eq(true) }
      end

    end

  #############################################
  #############################################

end

###############################################
###############################################
