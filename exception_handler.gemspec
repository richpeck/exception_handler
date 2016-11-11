# Dependencies
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

##############################################################
##############################################################

# => Version
# => https://github.com/rails/rails/blob/master/version.rb
module ExceptionHandler
  module VERSION
    MAJOR = 0
    MINOR = 6
    TINY  = 5
    PRE   = nil # "alpha"

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join(".")
  end
end

# => Declaration
# => https://github.com/rails/rails/blob/master/rails.gemspec#L1
version = ExceptionHandler::VERSION::STRING

##############################################################
##############################################################

# => Gem
Gem::Specification.new do |s|

  ##############################################################

  # => General
  s.platform      = Gem::Platform::RUBY
  s.name          = "exception_handler"
  s.version       = version

  # => Author
  s.authors       = ["Richard Peck"]
  s.email         = ["rpeck@frontlineutilities.co.uk"]

  # => Details
  s.summary       = %q{Rails gem to show custom error pages in production. Also logs errors in db & sends notification emails}
  s.description   = %q{Rails gem to create custom error pages. Captures exceptions using "exception_app" callback, routing to "Exception" controller, rendering the view as required.}
  s.homepage      = "http://github.com/richpeck/exception_handler"

  # => License
  s.license       = "MIT"

  ##############################################################

  # => Files
  # => Remove "readme" dir from gem
  s.files         = `git ls-files -z`.split("\x0")
  s.files.reject! { |fn| fn.include? "readme" } #-> https://github.com/gauntlt/gauntlt/blob/master/gauntlt.gemspec#L16

  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/}) unless RUBY_VERSION >= "2.2.0" #-> deprecated in Ruby 2.2.0
  s.require_paths = ["lib"]

  ##############################################################

  # => Ruby
  s.required_ruby_version = ">= 2.1.0"

  # => Runtime
  s.add_dependency "bundler",    "~> 1.6"
  s.add_dependency "rails",      ">= 4.2.0"
  s.add_dependency "responders", "~> 2.3"

  # => Extras
  s.add_development_dependency "autoprefixer-rails"

  # => Dev
  # => For testing etc
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3",     ">= 1.3.10"

##############################################################
##############################################################

end
