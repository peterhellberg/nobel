# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nobel/version'

Gem::Specification.new do |gem|
  gem.required_ruby_version = '>= 1.9.3'

  gem.name          = "nobel"
  gem.version       = Nobel::VERSION
  gem.authors       = ["Peter Hellberg"]
  gem.email         = ["peter@c7.se"]
  gem.summary       = %q{API client for the Nobel Prize API}
  gem.homepage      = "https://github.com/peterhellberg/nobel"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.require_paths = ["lib"]
end
