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
RSpec.describe ExceptionHandler::Engine do

  #############################################
  #############################################

    # => Ensure Gem has value, loaded etc
    describe "Gem" do

      # => Options
      let(:version) { ExceptionHandler::VERSION::STRING }
      let(:engine)  { ExceptionHandler::Engine }

      # => Version needs to exist
      # => Present Version
      describe "version" do
        subject { version }
        it { is_expected.not_to be_empty }
        it { is_expected.to eq('0.8.0.0') }
      end

      # => Loaded?
      # => Accessible by Rails?
      describe "class" do
        subject { engine }
        it { should be_const_defined('ExceptionHandler') }
        it { }
      end

    end

  #############################################
  #############################################

    # => Ensure Gem's features are loaded into Rails
    describe "Setup" do

      #########################
      #########################

        # => Options
        let(:config) { ExceptionHandler.config }
        let(:rails)  { Rails.configuration }

        # => Before
        before(:context) { ExceptionHandler.config.dev = false }
        before(:context) { puts "test" }

      #########################
      #########################

        # => Config
        # => Exists? Accessible? Right Values?
        describe "config" do
          subject { config }
          it { should be_a ExceptionHandler::Config }
          # => accessible
          # => values
        end

      #########################
      #########################

        # => Middleware
        # => Check if it's correctly overwritten @exceptions_app
        # => http://guides.rubyonrails.org/configuring.html#rails-general-configuration
        describe "middleware" do
          subject { rails.exceptions_app }
          #it      { should eq(ExceptionHandler) }
          # => accessible?
        end

      #########################
      #########################

        # => Dev Mode
        # => Changes "consider_all_requests_local" to opposite of config
        describe "dev" do

          # => Access dev mode
          # => Ensure the config is present & accessible
          context "config" do
            subject { config.dev }
            it { should_not be true }
          end

          # => Local Requests
          # => Should be the opposite of the dev option
          context "local requests" do
            subject { rails.consider_all_requests_local }
            it { should_not be ExceptionHandler.config.dev }
          end

        end

      #########################
      #########################

        # => Custom Exceptions
        # => Ensure custom exceptions added to Rails
        describe "custom exceptions" do

          # => Rescue Response
          subject { rails.action_dispatch.rescue_responses }

          # => Let
          let(:config) { ExceptionHandler.config }

          # => Check if present
          context "present" do

          end

          # => Check if can be accessed
          context "accessiblity" do
            before { config.custom_exceptions.merge! 'ActionController::RoutingError' => :not_found }
            #it { should include config.custom_exceptions }
          end

        end

      end

  #############################################
  #############################################

end

###############################################
###############################################
