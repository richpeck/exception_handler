########################################################################################
########################################################################################

# => Version
require_relative 'lib/exception_handler/version'

##############################################################
##############################################################

## Specs ##
Gem::Specification.new do |s|

  ## General ##
  s.name                  = "exception_handler"
  s.authors               = ["R.Peck"]
  s.email                 = ["rpeck@fl.co.uk"]
  s.version               = ExceptionHandler::VERSION::STRING
  s.platform              = Gem::Platform::RUBY

  ## Details ##
  s.summary               = %q{Rails gem to show custom error pages in production. Also logs errors in db & sends notification emails}
  s.description           = %q{Rails gem to create custom error pages. Captures exceptions using "exception_app" callback, routing to "Exception" controller, rendering the view as required.}
  s.homepage              = "https://github.com/richpeck/exception_handler"

  ## License ##
  s.license       = "MIT"

  ##############################################################
  ##############################################################

  ## Files ##
  s.files         = `git ls-files -z`.split("\x0")
  s.files.reject! { |fn| fn.include? "readme" } #-> https://github.com/gauntlt/gauntlt/blob/master/gauntlt.gemspec#L16

  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/}) unless RUBY_VERSION >= "2.2.0" #-> deprecated in Ruby 2.2.0
  s.require_paths = ["lib"]

  ##############################################################
  ##############################################################

  ## Ruby ##
  s.required_ruby_version = ">= 2.1.0"

  ## Runtime
  s.add_dependency "bundler"
  s.add_dependency "rails",      ">= 4.2.0"
  s.add_dependency "responders"

  ## Extras ##
  s.add_development_dependency "autoprefixer-rails"

  ## Dev ##
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "coveralls"  
  s.add_development_dependency "sqlite3", ">= 1.3.10"

##############################################################
##############################################################

end
