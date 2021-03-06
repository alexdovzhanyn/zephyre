# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zephyre/version'

Gem::Specification.new do |spec|
  spec.name          = "zephyre"
  spec.version       = Zephyre::VERSION
  spec.authors       = ["Alex Dovzhanyn"]
  spec.email         = ["dovzhanyn.alex@gmail.com"]

  spec.summary       = %q{A small, open-source ruby web framework.}
  spec.description   = %q{Zephyre is a web development framework built on Rack. Use Zephyre to build quick websites with ruby.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = ["zephyre"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  
  # spec.add_runtime_dependency "pry"
  spec.add_runtime_dependency "rack"
end
