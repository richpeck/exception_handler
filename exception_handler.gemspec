# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exception_handler/version'

Gem::Specification.new do |s|

  # General
  s.name          = "exception_handler"
  s.version       = ExceptionHandler::VERSION
  s.authors       = ["Richard Peck"]
  s.email         = ["rpeck@frontlineutilities.co.uk"]
  s.summary       = %q{Rails gem to show custom error pages in production. Also logs errors in db & sends notification emails}
  s.description   = %q{Rails gem to create custom error pages. Captures exceptions using "exception_app" callback, routing to "Exception" controller, rendering the view as required.}
  s.homepage      = "http://github.com/richpeck/exception_handler"
  s.license       = "MIT"

  # Files
  s.files         = `git ls-files -z`.split("\x0")
  s.files.reject! { |fn| fn.include? "readme" } #-> https://github.com/gauntlt/gauntlt/blob/master/gauntlt.gemspec#L16

  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/}) unless RUBY_VERSION >= "2.2.0" #-> deprecated in Ruby 2.2.0
  s.require_paths = ["lib"]

  # Options
  s.post_install_message = File.read(File.join(File.dirname(__FILE__), 'post_install_message.md')) #-> https://github.com/jarrett/ichiban/blob/master/ichiban.gemspec#L35

  # dev Dependencies
  s.add_development_dependency "bundler", "~> 1.6"
  s.add_development_dependency "rails", "~> 4.0.0"
  s.add_development_dependency "activerecord"
  s.add_development_dependency "activesupport"  
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 3.3"
  s.add_development_dependency "rspec-rails", "~> 3.3"
  s.add_development_dependency "sqlite3", "~> 1.3.10"

end