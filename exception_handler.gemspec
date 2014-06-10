# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exception_handler/version'

Gem::Specification.new do |spec|
  spec.name          = "exception_handler"
  spec.version       = ExceptionHandler::VERSION
  spec.authors       = ["Richard Peck", "Joe Hilton"]
  spec.email         = ["rpeck@frontlineutilities.co.uk", "jhilton@frontlineutilities.co.uk"]
  spec.summary       = %q{Rails gem to show custom error pages in production. Also logs errors in "errors" db if required}
  spec.description   = %q{Rails gem to create custom error pages. Captures exceptions using "exception_app" callback, routing to "Exception" controller, rendering the view as required.}
  spec.homepage      = "http://frontlineutilities.co.uk/ror/custom_error_pages"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rails", "~> 4.0.0"
  spec.add_development_dependency "activerecord"
  spec.add_development_dependency "activesupport"  
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end