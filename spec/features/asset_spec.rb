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

# => ExceptionHandler (Assets)
# => Needs to test if exception_handler.css added to precompile queue
# => Needs to test if exception_handler.css adds /images folder
# => Needsd to check if all files are precompiled
RSpec.describe "ExceptionHandler Assets" do

  # => Defs
  let(:assets)    { Rails.configuration.assets }
  let(:sprockets) { Rails.application.assets }

  # => Precompilation
  # => Expects exception_handler.css
  # => Expects contents of /images to be included by file
  describe "precompile" do
    subject { assets.precompile }
    it { should include('exception_handler.css') }
  end

  # => Images
  # => Should be present in Rails.application.assets
  # => ref: https://stackoverflow.com/a/11005361/1143732
  describe "images" do
    it "includes exception_handler/images/*" do
      #Dir.foreach('../../../app/assets/images') do |item|
      #  next if item == '.' or item == '..'
      #  puts item
      #  expect(sprockets.each_file).to include(item)
      #end
    end
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
