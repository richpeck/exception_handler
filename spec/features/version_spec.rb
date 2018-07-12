###############################################
###############################################
##     _   _               _                 ##
##    | | | |             (_)                ##
##    | | | | ___ _ __ ___ _  ___  _ __      ##
##    | | | |/ _ \ '__/ __| |/ _ \| '_ \     ##
##    \ \_/ /  __/ |  \__ \ | (_) | | | |    ##
##     \___/ \___|_|  |___/_|\___/|_| |_|    ##
##                                           ##
###############################################
###############################################

require 'spec_helper'

###############################################
###############################################

# => ExceptionHandler (base)
# => Test underlying engine (loading, initializers, etc)
# => Ensure that all elements are correctly integrated into Rails core
RSpec.describe ExceptionHandler::VERSION do

  #############################################
  #############################################

  # => Version
  let(:version) { ExceptionHandler::VERSION::STRING }

  # => Version needs to exist
  # => Present Version
  describe "version" do
    subject { version }
    it { is_expected.not_to be_empty }
    it { is_expected.to eq('0.8.0.0') }
  end

  #############################################
  #############################################

end

###############################################
###############################################
