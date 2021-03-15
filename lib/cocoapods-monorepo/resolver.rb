require 'cocoapods'
require 'cocoapods-monorepo/podspec_local_cache'

module Pod
  class Resolver

    # Hook the original `find_cached_set` method.
    alias_method :origin_find_cached_set, :find_cached_set

    # Load and return the dependencies set of the given Pod.
    def find_cached_set(dependency)
      unless dependency.external_source

        name = dependency.root_name
        podspec_path = podspec_local_cache.local_podspecs[name]
        unless podspec_path.nil?
          # Specify the local pod as external source.
          dependency.external_source = {}
          dependency.external_source[:path] = podspec_path
          stored_to_sandbox_podspecs(name, dependency)
        end
        
      end
      
      origin_find_cached_set(dependency)
    end

    # Cache the pod which already stored into sandbox to avoid repeating injection.
    def stored_sandbox_podspecs
      @stored_sandbox_podspecs ||= {}
    end

    # Store the pod into sandbox as external source.
    def stored_to_sandbox_podspecs(name, dependency)
      stored_sandbox_podspecs[name] ||= begin
        source = ExternalSources.from_dependency(dependency, podfile.defined_in_file, true)
        source.fetch(sandbox)
        dependency
      end
    end

    # The cache of `podspec`
    def podspec_local_cache
      @podspec_local_cache ||= CocoapodsMonorepo::PodspecLocalCache.from_local_path(Resolver.monorepo_path)
    end
     
    # Represent monorepo's directory that you want read from.
    @monorepo_path = ""
    
    class << self
      attr_accessor :monorepo_path
    end

  end
end
