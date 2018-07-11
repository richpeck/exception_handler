###############################################
###############################################
##         ___               _               ##
##        / _ \             | |              ##
##       / /_\ \___ ___  ___| |_ ___         ##
##       |  _  / __/ __|/ _ \ __/ __|        ##
##       | | | \__ \__ \  __/ |_\__ \        ##
##       \_| |_/___/___/\___|\__|___/        ##
##                                           ##
###############################################
###############################################

require 'spec_helper'

###############################################
###############################################

# => ExceptionHandler (Config)
# => Should explore config has been created/initialized
# => Needs to identify available options         (dev/db/email/social/layouts/exceptions/custom_exceptions)
# => Needs to return specific results per option (dev = true/false, email = string etc)
RSpec.describe "ExceptionHandler Assets" do

  # => Defs
  let(:assets) { Rails.configuration.assets.precompile }

  # => Precompilation
  # => Expects exception_handler.css
  # => Expects contents of /images to be included by file
  describe "precompile" do
    subject { assets }
    it { should include('exception_handler.css') }
  end

  # => Assets
  # => Expects exception_handler.css
  # => Expects /images
  # => Expects /images/[specific]
  describe "assets" do
    #it { expect(Rails.application.assets.find_asset(path)).to include('exception_handler.css') }
  end


end

###############################################
###############################################
