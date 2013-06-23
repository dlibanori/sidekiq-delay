# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidekiq/delay/version'

Gem::Specification.new do |spec|
  spec.name          = "sidekiq-delay"
  spec.version       = Sidekiq::Delay::VERSION
  spec.authors       = ["Daniel Libanori"]
  spec.email         = ["daniellibanori@gmail.com"]
  spec.description   = %q{Wouldn't be nice if you could directly queue your model method calls to Sidekiq? With Sidekiq::Delaty you can!}
  spec.summary       = %q{Queue model method calls at Sidekiq}
  spec.homepage      = "http://dlibanori.github.io/sidekiq-delay/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sidekiq", "~> 2.12.4"
  spec.add_dependency "activesupport", "~> 3.2.13"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
