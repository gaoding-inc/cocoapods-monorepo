# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-monorepo/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-monorepo'
  spec.version       = CocoapodsMonorepo::VERSION
  spec.authors       = ['menttofly']
  spec.email         = ['1028265614@qq.com']
  spec.description   = %q{A assistant for code organization by using monorepo.}
  spec.summary       = %q{`cocoapods monorepo` will make the dependencies that under specified directory into development pods.}
  spec.homepage      = 'https://github.com/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
