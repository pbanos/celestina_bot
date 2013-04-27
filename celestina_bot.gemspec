# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'celestina_bot/version'

Gem::Specification.new do |spec|
  spec.name          = "celestina_bot"
  spec.version       = CelestinaBot::VERSION
  spec.authors       = ["Pablo Baños López"]
  spec.email         = ["pablo@besol.es"]
  spec.description   = %q{Twitter bot that proposes matches between its followers}
  spec.summary       = %q{This gem provides a twitter bot that proposes matches between its followers}
  spec.homepage      = "https://github.com/pbanos/celestina_bot"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency 'grackle', '~> 0.3.0'
  spec.add_dependency 'daemons', '~> 1.1.9'
end
