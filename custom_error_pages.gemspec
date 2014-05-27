# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'custom_error_pages/version'

Gem::Specification.new do |spec|
  spec.name          = "custom_error_pages"
  spec.version       = CustomErrorPages::VERSION
  spec.authors       = ["Richard Peck"]
  spec.email         = ["rpeck@frontlineutilities.co.uk"]
  spec.summary       = %q{Rails gem to show custom error pages in production. Also logs errors in "errors" db if required}
  spec.description   = %q{Rails gem to create custom error pages. Captures exceptions using "exception_app" callback, routing to "Exception" controller, rendering the view as required.}
  spec.homepage      = "http://frontlineutilities.co.uk/ror/custom_error_pages"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "action_dispatch"
end
