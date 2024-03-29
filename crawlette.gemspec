# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crawlette/version'

Gem::Specification.new do |spec|
  spec.name          = "crawlette"
  spec.version       = Crawlette::VERSION
  spec.authors       = ["Miguel Camba"]
  spec.email         = ["miguel.camba@gmail.com"]
  spec.summary       = %q{Very simple web crawler}
  spec.description   = %q{Crawls a page, with no limits and without visiting external domains}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "nokogiri", '~> 1.6'
  spec.add_runtime_dependency "awesome_print", '~> 1.2'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
end
