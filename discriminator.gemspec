# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'discriminator/version'

Gem::Specification.new do |spec|
  spec.name          = "discriminator"
  spec.version       = Discriminator::VERSION
  spec.authors       = ["James Kiesel"]
  spec.email         = ["james.kiesel@gmail.com"]

  spec.summary       = "Discriminate class type based on a model field"
  spec.homepage      = "https://github.com/gdpelican/discriminator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activerecord", ">= 4.0.2"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
