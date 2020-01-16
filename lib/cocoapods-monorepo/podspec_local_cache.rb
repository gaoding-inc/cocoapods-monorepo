require 'cocoapods'

module CocoapodsMonorepo
    # 缓存指定目录下所有组件的podspec
    class PodspecLocalCache
        # @return [Hash<String => String>]
        # 指定目录下的所有podspec
        attr_reader :local_podspecs

        def initialize(local_podspecs)
            @local_podspecs = local_podspecs
        end

        # 从指定路径创建PodspecLocalCache实例
        def self.from_local_path(directory_path)
            unless File.directory?(directory_path)
              raise ArgumentError, "[monorepo-plugin]: ☠️`#{directory_path}`不是一个目录"
            end
            podspecs = {}
            podspec_files = Dir.glob(File.join(directory_path, "*", "*.podspec"))
            podspec_files.each do |podspec_file|
                specification = Pod::Specification.from_file(podspec_file)
                validate_podspec(specification)
                podspecs[specification.name] = specification.defined_in_file.to_s
            end
            new(podspecs.freeze)
        end

        # 验证podspec文件是否有效
        def self.validate_podspec(podspec)
            defined_in_file = podspec.defined_in_file
            podspec.defined_in_file = nil
    
            validator = validator_for_podspec(podspec)
            validator.quick = true
            validator.allow_warnings = true
            validator.ignore_public_only_results = true
            Pod::Config.instance.with_changes(:silent => true) do
              validator.validate
            end
            unless validator.validated?
              raise Informative, "[monorepo-plugin]: ☠️`#{name}` 验证podspec文件失败: #{validator.failure_reason}:\n#{validator.results_message}"
            end
          ensure
            podspec.defined_in_file = defined_in_file
          end
    
          def self.validator_for_podspec(podspec)
            Pod::Validator.new(podspec, [], [])
          end
    end
end
