###############################################
###############################################
##      _____              __ _              ##
##     /  __ \            / _(_)             ##
##     | /  \/ ___  _ __ | |_ _  __ _        ##
##     | |    / _ \| '_ \|  _| |/ _` |       ##
##     | \__/\ (_) | | | | | | | (_| |       ##
##      \____/\___/|_| |_|_| |_|\__, |       ##
##                               __/ |       ##
##                              |___/        ##
###############################################
###############################################

require 'spec_helper'

###############################################
###############################################

# => ExceptionHandler (Config)
# => Should explore config has been created/initialized
# => Needs to identify available options         (dev/db/email/social/layouts/exceptions/custom_exceptions)
# => Needs to return specific results per option (dev = true/false, email = string etc)
RSpec.describe ExceptionHandler.config do

  # => Config
  let(:config) { ExceptionHandler.config }

  # => Class
  # => Initialized?
  # => Responds to methods?
  describe "class" do
    subject { config }
    it { should be_a ExceptionHandler::Config }
    %i(dev db email social layouts exceptions custom_exceptions).each do |method|
      it { should respond_to(method) }
    end
  end

  # => Dev
  # => true/false
  describe "dev" do
    subject { ExceptionHandler.config.dev }
    #it { should be_boolean }
  end

  # => DB

end

###############################################
###############################################
