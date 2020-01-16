# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-monorepo/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-monorepo'
  spec.version       = CocoapodsMonorepo::VERSION
  spec.authors       = ['menttofly']
  spec.email         = ['1028265614@qq.com']
  spec.description   = %q{本插件用于解决mono-repo组件化中本地pod连环依赖的问题.}
  spec.summary       = %q{本插件用于解决mono-repo组件化中本地pod连环依赖的问题.}
  spec.homepage      = 'https://github.com/menttofly/cocoapods-monorepo.git'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
