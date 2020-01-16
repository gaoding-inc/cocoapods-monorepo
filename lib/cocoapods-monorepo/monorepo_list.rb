require 'cocoapods'
require 'fileutils'

module CocoapodsMonorepo
    class MonorepoList

        # 列出Podfile中所有本地组件依赖
        def self.list_podfile_component(podfile_path, modules_path)
            podfile = Pod::Podfile.from_file(podfile_path)
            # 如果指定了subspecs，则dependency.name会类似于React/Core、React/ART
            dependencies = podfile.dependencies.map(&:root_name).compact

            result = []
            # 时间复杂度O(m*n)
            # 也可以直接使用pod依赖全路径，判断是否存在该目录，时间复杂度O(n)
            Dir.foreach(modules_path) do |name| 
                if name == "." || name == ".." || !File.directory?(File.join(modules_path, name))
                    next
                end
                
                # 在Podfile依赖数组中查找
                match = dependencies.find { |dependency| dependency == name }
                result.push(match) unless match.nil?
            end

            result.uniq
        end
    end
end
