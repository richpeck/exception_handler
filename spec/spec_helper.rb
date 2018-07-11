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

# => Helper
require 'spec_helper'

# => ENV
ENV["RAILS_ENV"] ||= "test"

# => Rails
require_relative './dummy/config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?

# => RSpec
require 'rspec/rails'

# => Environment
ActiveRecord::Migrator.migrations_paths = [File.expand_path("./dummy/db/migrate", __dir__)]

# => Gem (to test)
require 'exception_handler'

###############################################
###############################################

# => ActiveRecord
ActiveRecord::Migration.maintain_test_schema!

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("fixtures", __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end

###############################################
###############################################

#=> Custom Matchers
RSpec::Matchers.define :be_boolean do
 match do |value|
   [true, false].include? value
 end
end

###############################################
###############################################

# => http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|

  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # => Rails (Fixtures etc)
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.order = :random

  # => Asset Precompile
  config.before(:suite) do
    Rails.application.load_tasks
    Rake::Task["assets:precompile"].invoke
  end

  config.after(:suite) do
    Rails.application.load_tasks
    Rake::Task["assets:clobber"].invoke
  end
end
