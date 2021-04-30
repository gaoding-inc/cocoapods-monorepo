require 'cocoapods'

module CocoapodsMonorepo
  
    # Cache all path of the `podspec` under the specified directory.
    class PodspecLocalCache
        # @return [Hash<String => String>]
        # All podspec under specified directory.
        attr_reader :local_podspecs

        def initialize(local_podspecs)
            @local_podspecs = local_podspecs
        end

        # Create instance of `PodspecLocalCache` from some directory.
        def self.from_local_path(directory_path)
            unless File.directory?(directory_path)
              raise Pod::Informative, "[cocoapods-monorepo]: `#{directory_path}` is not a directory!"
            end
            podspecs = {}
            podspec_files = Dir.glob(File.join(directory_path, "**", "*.podspec"))
            podspec_files.each do |podspec_file|
                specification = Pod::Specification.from_file(podspec_file)
                validate_podspec(specification)
                podspecs[specification.name] = specification.defined_in_file.to_s
            end
            new(podspecs.freeze)
        end

        # Checking whether `podspec` is valid or not.
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
              raise Pod::Informative, "[cocoapods-monorepo]: `#{name}` is failed for validation: #{validator.failure_reason}:\n#{validator.results_message}"
            end
          ensure
            podspec.defined_in_file = defined_in_file
          end
    
          def self.validator_for_podspec(podspec)
            Pod::Validator.new(podspec, [], [])
          end
    end
end
