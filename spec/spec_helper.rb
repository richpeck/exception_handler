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

# => http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|

  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|

    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true

    # => Default Syntax
    expectations.syntax = :expect
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # => Rails (Fixtures etc)
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"
  #config.use_transactional_fixtures = true
  #config.infer_spec_type_from_file_location!
  #config.filter_rails_from_backtrace!

end
