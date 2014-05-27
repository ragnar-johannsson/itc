# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itc/version'

Gem::Specification.new do |spec|
  spec.name          = "itc"
  spec.version       = Itc::VERSION
  spec.authors       = ["Ragnar B. Johannsson"]
  spec.email         = ["ragnar@igo.is"]
  spec.summary       = %q{iTunes CLI}
  spec.description   = %q{iTunes CLI with tab completions}
  spec.homepage      = "https://github.com/ragnar-johannsson/itc"
  spec.license       = "BSD"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "sqlite3", "~> 1.3.9"
  spec.add_runtime_dependency "htmlentities", "~> 4.3.1"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
