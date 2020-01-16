require 'cocoapods'
require 'cocoapods-monorepo/podspec_local_cache'

module Pod
  class Resolver

    # hook原始的find_cached_set方法
    alias_method :origin_find_cached_set, :find_cached_set

    # 加载或返回给定Pod依赖的初始化集合
    def find_cached_set(dependency)
      unless dependency.external_source

        name = dependency.root_name
        podspec_path = podspec_local_cache.local_podspecs[name]
        unless podspec_path.nil?
          # 属于本地组件的为其指定为外部源
          dependency.external_source = {}
          dependency.external_source[:path] = podspec_path
          stored_to_sandbox_podspecs(name, dependency)
        end
      end
      
      origin_find_cached_set(dependency)
    end

    # 缓存已写入sandbox的组件pod，避免重复注入
    def stored_sandbox_podspecs
      @stored_sandbox_podspecs ||= {}
    end

    # 将组件pod作为外部源写入sandbox
    def stored_to_sandbox_podspecs(name, dependency)
      stored_sandbox_podspecs[name] ||= begin
        source = ExternalSources.from_dependency(dependency, podfile.defined_in_file, true)
        source.fetch(sandbox)
        dependency
      end
    end

    # podspec缓存
    def podspec_local_cache
      @podspec_local_cache ||= CocoapodsMonorepo::PodspecLocalCache.from_local_path(podspec_local_path)
    end

    # podspec缓存所在的组件目录
    def podspec_local_path
      File.join(`git rev-parse --show-toplevel`.chomp, 'modules')
    end

  end

end
