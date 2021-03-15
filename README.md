# cocoapods-monorepo

A tool for organizing code like monorepo.

`cocoapods-monorepo` allowed you to specify a directory, so we can extend CocoaPods to support `monorepo` feature. Thanks to this plugin we can turn all the pods that under the specified directory into `Development Pods`. 

## Installation

    $ gem install cocoapods-monorepo

## Usage

Add a reference to it in your `Podfile`, and specified the necessary option `:path` : 

```ruby
plugin 'cocoapods-monorepo', :path => 'path/to/repos-directory'
```

Enjoy it!

