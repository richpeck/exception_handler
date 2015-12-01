# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exception_handler/version'

Gem::Specification.new do |s|
  s.name          = "exception_handler"
  s.version       = ExceptionHandler::VERSION
  s.authors       = ["Richard Peck", "Joe Hilton"]
  s.email         = ["rpeck@frontlineutilities.co.uk", "jhilton@frontlineutilities.co.uk"]
  s.summary       = %q{Rails gem to show custom error pages in production. Also logs errors in "errors" db if required}
  s.description   = %q{Rails gem to create custom error pages. Captures exceptions using "exception_app" callback, routing to "Exception" controller, rendering the view as required.}
  s.homepage      = "http://frontlineutilities.co.uk/ror/custom_error_pages"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.post_install_message = File.read(File.join(File.dirname(__FILE__), 'post_install_message.md')) #-> https://github.com/jarrett/ichiban/blob/master/ichiban.gemspec#L35

  s.add_development_dependency "bundler", "~> 1.6"
  s.add_development_dependency "rails", "~> 4.0.0"
  s.add_development_dependency "activerecord"
  s.add_development_dependency "activesupport"  
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end