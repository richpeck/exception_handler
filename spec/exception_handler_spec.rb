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

class TestPlugin::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, TestPlugin
  end
end

# => ExceptionHandler (base)
RSpec.describe ExceptionHandler do

  # => Default
  # => Version needs to be present
  it "has a version number" do
    expect(ExceptionHandler::VERSION::STRING).not_to be nil
  end

end

###############################################
###############################################
