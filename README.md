# cocoapods-monorepo
[![Gem Version](https://badge.fury.io/rb/cocoapods-monorepo.svg)](https://badge.fury.io/rb/cocoapods-monorepo)

A tool for organizing code in `monorepo` way.

`cocoapods-monorepo` allowed you to specify a directory, so we can extend CocoaPods to support `monorepo` feature. Thanks to this plugin we can turn all the pods that under a specified directory into `Development Pods`. You will no longer need to specify all local paths in the `Podfile`, eg:

```ruby
pod 'ModuleA', :path => 'path/to/ModuleA'
pod 'ModuleB', :path => 'path/to/ModuleB'
pod 'ModuleC', :path => 'path/to/ModuleC'
```

Besides, you can also specify a local dependency in `podsepc`, that's say you need to declare a dependency of `ModuleB `  in `ModuleA.podspec`: 

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

## Requirements

You need to orgnize all these local modules under the same directory with `:path` option.

```bash
.
├── ModuleA
│   ├── ModuleA.podspec
│   └── README.md
├── ModuleB
│   ├── ModuleB.podspec
│   ├── README.md
├── ModuleC
│   ├── ModuleC.podspec
│   ├── README.md
```

*Enjoy it!*

