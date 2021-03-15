# cocoapods-monorepo

A tool for organizing code in a way of monorepo.

`cocoapods-monorepo` allowed you to specify a directory, so we can extend CocoaPods to support `monorepo` feature. Thanks to this plugin we can turn all the pods that under a specified directory into `Development Pods`. You will no longer need to specify all local paths in the `Podfile`, eg:

```ruby
pod 'ModuleA', :path => 'path/to/ModuleA'
pod 'ModuleB', :path => 'path/to/ModuleB'
pod 'ModuleC', :path => 'path/to/ModuleC'
```

And it also support specify a local dependency in `podsepc`, that's say you need to declare a dependency of `ModuleB `  in `ModuleA.podspec`: 

```ruby
s.dependency 'ModuleB' # inside ModuleA.podspec
```

## Installation

    $ gem install cocoapods-monorepo

## Usage

Add a reference to it in your `Podfile`, and specified the necessary option `:path` : 

```ruby
plugin 'cocoapods-monorepo', :path => 'path/to/repos-directory'
```

And you also need to orgnize all you local modules under the same directory same as `:path` option.

Enjoy it!

